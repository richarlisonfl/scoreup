let cadastroCards = {};
let users = [];
let currentUser = null;

document.addEventListener('DOMContentLoaded', async function () {
    try {
        const response = await fetch('./dados.json');
        const data = await response.json();
        cadastroCards = data.cadastroCards;
        users = data.users;
        atualizarListaUsuarios();
    } catch (err) {
        console.error('Erro ao carregar dados.json:', err);
        showNotification('error', 'Erro', 'Falha ao carregar configurações do sistema.');
        return;
    }

    // === Inicialização ===
    showScreen('telaInicio');
    document.querySelectorAll('.user-area').forEach(el => el.style.display = 'none');

    // === Login ===
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const user = users.find(u => u.username === username && u.password === password);
        const errorEl = document.getElementById('loginError');
        const loading = document.getElementById('loginButtonLoading');
        const text = document.getElementById('loginButtonText');

        text.classList.add('hidden');
        loading.classList.remove('hidden');

        setTimeout(() => {
            if (user) {
                currentUser = user;
                errorEl.classList.add('hidden');
                document.getElementById('userDisplayName').textContent = `Olá, ${user.name}`;
                document.getElementById('userDisplayNameMobile').textContent = user.name;
                createCadastroCards(user.permissions);
                hideLoginModal();
                document.getElementById('guestArea').style.display = 'none';
                document.getElementById('guestAreaMobile').style.display = 'none';
                document.getElementById('userArea').style.display = 'flex';
                document.getElementById('userAreaMobile').style.display = 'block';
                document.querySelectorAll('.user-area').forEach(el => el.style.display = 'block');
                showNotification('success', 'Login realizado', `Bem-vindo(a), ${user.name}`);
            } else {
                errorEl.classList.remove('hidden');
                text.classList.remove('hidden');
                loading.classList.add('hidden');
            }
        }, 1000);
    });

    // === Botões de logout ===
    ['logoutButton', 'logoutButtonMobile'].forEach(id => {
        document.getElementById(id).addEventListener('click', () => {
            if (confirm('Deseja realmente sair do sistema?')) logout();
        });
    });

    // === Botões de login ===
    ['showLoginButton', 'showLoginButtonMobile'].forEach(id => {
        document.getElementById(id).addEventListener('click', () => {
            showLoginModal();
            if (id === 'showLoginButtonMobile') document.getElementById('mobile-menu').classList.add('hidden');
        });
    });

    // === Fecha modal de login ===
    document.getElementById('closeLoginButton').addEventListener('click', hideLoginModal);
    document.getElementById('loginScreen').addEventListener('click', function (e) {
        if (e.target === this) hideLoginModal();
    });

    // === Navegação ===
    document.getElementById('navInicio').addEventListener('click', (e) => {
        e.preventDefault();
        showScreen('telaInicio');
        setActiveNavItem('navInicio', 'navInicioMobile');
    });

    document.getElementById('navInicioMobile').addEventListener('click', (e) => {
        e.preventDefault();
        showScreen('telaInicio');
        setActiveNavItem('navInicio', 'navInicioMobile');
        document.getElementById('mobile-menu').classList.add('hidden');
    });

    document.getElementById('navCadastros').addEventListener('click', (e) => {
        e.preventDefault();
        if (!currentUser) {
            showLoginModal();
            showNotification('warning', 'Acesso restrito', 'Faça login para acessar os cadastros.');
            return;
        }
        showScreen('telaCadastros');
        setActiveNavItem('navCadastros', 'navCadastrosMobile');
    });

    document.getElementById('navCadastrosMobile').addEventListener('click', (e) => {
        e.preventDefault();
        if (!currentUser) {
            showLoginModal();
            showNotification('warning', 'Acesso restrito', 'Faça login para acessar os cadastros.');
            return;
        }
        showScreen('telaCadastros');
        setActiveNavItem('navCadastros', 'navCadastrosMobile');
        document.getElementById('mobile-menu').classList.add('hidden');
    });

    // === Menu mobile ===
    document.getElementById('mobile-menu-button').addEventListener('click', () => {
        document.getElementById('mobile-menu').classList.toggle('hidden');
    });

    // === Abas ===
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            const id = tab.getAttribute('data-tab');
            document.getElementById(id).classList.add('active');
        });
    });

    // === Tecla ESC ===
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            if (currentUser && confirm('Deseja sair do sistema?')) {
                logout();
            } else if (!document.getElementById('loginScreen').classList.contains('hidden')) {
                hideLoginModal();
            }
        }
    });
});

// === Cadastro e visualização de usuários ===

function submitForm(event, type) {
    event.preventDefault();

    if (currentUser && !currentUser.permissions.includes(type)) {
        showNotification('error', 'Acesso negado', 'Você não tem permissão.');
        return;
    }

    if (type === 'usuario') {
        const formData = new FormData(event.target);
        const novoUsuario = {
            username: formData.get('username'),
            password: formData.get('password') || '123456',
            name: formData.get('name'),
            role: formData.get('role'),
            campus: formData.get('campus'),
            permissions: ['usuario']
        };
        users.push(novoUsuario);
        atualizarListaUsuarios();
    }

    setTimeout(() => {
        showNotification('success', 'Cadastro realizado', `Cadastro de ${type} concluído!`);
        hideForm(`${type}Form`);
        event.target.reset();
    }, 500);
}

function atualizarListaUsuarios() {
    const container = document.getElementById('listaUsuarios');
    if (!container || users.length === 0) {
        container.innerHTML = '<p class="text-gray-500">Nenhum usuário cadastrado.</p>';
        return;
    }

    let html = `
        <h3 class="text-lg font-bold mb-2">Usuários cadastrados:</h3>
        <ul class="space-y-2">
            ${users.map(user => `
                <li class="bg-white shadow rounded p-3">
                    <strong>${user.name}</strong> (${user.username}) - ${user.role}, ${user.campus || ''}
                </li>
            `).join('')}
        </ul>
    `;
    container.innerHTML = html;
}

// === Funções auxiliares ===

function createCadastroCards(permissions) {
    const container = document.getElementById('menuCardGrid');
    container.innerHTML = '';
    const sorted = [...permissions].sort((a, b) => cadastroCards[a].order - cadastroCards[b].order);
    sorted.forEach(permission => {
        const card = cadastroCards[permission];
        const div = document.createElement('div');
        div.className = 'bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow';
        div.innerHTML = `
            <div class="ifpa-green p-4 text-white">
              <i class="fas ${card.icon} text-2xl"></i>
              <h3 class="text-xl font-semibold mt-2">${card.title}</h3>
            </div>
            <div class="p-4">
              <p class="text-gray-600 mb-4">${card.description}</p>
              <button onclick="showForm('${card.formId}')" class="w-full bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium py-2 px-4 rounded transition-colors">
                <i class="fas fa-edit mr-2"></i>Cadastrar
              </button>
            </div>
        `;
        container.appendChild(div);
    });
}

function showForm(formId) {
    const type = formId.replace('Form', '');
    if (currentUser && !currentUser.permissions.includes(type)) {
        showNotification('error', 'Acesso negado', 'Você não tem permissão.');
        return;
    }
    document.querySelectorAll('.form-container').forEach(form => form.style.display = 'none');
    const form = document.getElementById(formId);
    if (form) {
        form.style.display = 'block';
        form.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
}

function hideForm(formId) {
    const form = document.getElementById(formId);
    if (form) form.style.display = 'none';
}

function logout() {
    if (currentUser) showNotification('info', 'Logout', `Até logo, ${currentUser.name}!`);
    currentUser = null;
    document.getElementById('guestArea').style.display = 'block';
    document.getElementById('guestAreaMobile').style.display = 'block';
    document.getElementById('userArea').style.display = 'none';
    document.getElementById('userAreaMobile').style.display = 'none';
    document.querySelectorAll('.user-area').forEach(el => el.style.display = 'none');
    showScreen('telaInicio');
    setActiveNavItem('navInicio', 'navInicioMobile');
    document.getElementById('mobile-menu').classList.add('hidden');
}

function showLoginModal() {
    document.getElementById('loginScreen').classList.remove('hidden');
    document.getElementById('username').focus();
}

function hideLoginModal() {
    document.getElementById('loginScreen').classList.add('hidden');
    document.getElementById('username').value = '';
    document.getElementById('password').value = '';
    document.getElementById('loginError').classList.add('hidden');
    document.getElementById('loginButtonText').classList.remove('hidden');
    document.getElementById('loginButtonLoading').classList.add('hidden');
}

function showScreen(id) {
    ['telaInicio', 'telaCadastros'].forEach(screen => {
        document.getElementById(screen).classList.add('hidden');
    });
    document.getElementById(id).classList.remove('hidden');
}

function setActiveNavItem(desktopId, mobileId) {
    document.querySelectorAll('header a').forEach(item => {
        item.classList.remove('bg-green-800');
        item.classList.add('hover:text-green-200');
    });
    [desktopId, mobileId].forEach(id => {
        const el = document.getElementById(id);
        el.classList.add('bg-green-800');
        el.classList.remove('hover:text-green-200');
    });
}

function showNotification(type, title, message) {
    const el = document.getElementById('notification');
    document.getElementById('notificationTitle').textContent = title;
    document.getElementById('notificationMessage').textContent = message;
    const icon = document.getElementById('notificationIcon');
    const symbol = document.getElementById('notificationIconSymbol');

    const classes = {
        success: ['bg-green-100', 'text-green-500', 'fa-check'],
        error: ['bg-red-100', 'text-red-500', 'fa-times'],
        warning: ['bg-yellow-100', 'text-yellow-500', 'fa-exclamation'],
        info: ['bg-blue-100', 'text-blue-500', 'fa-info']
    };

    const [bg, text, iconClass] = classes[type] || classes.info;
    icon.className = `flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center mr-3 ${bg} ${text}`;
    symbol.className = `fas ${iconClass}`;

    el.classList.remove('hidden', 'scale-95', 'opacity-0');
    el.classList.add('scale-100', 'opacity-100');

    setTimeout(hideNotification, 5000);
}

function hideNotification() {
    const el = document.getElementById('notification');
    el.classList.remove('scale-100', 'opacity-100');
    el.classList.add('scale-95', 'opacity-0');
    setTimeout(() => el.classList.add('hidden'), 300);
}
//// ponto de verificação 1
