# Flutter Scaffold CLI

Uma CLI poderosa para gerar scaffolds de módulos Flutter seguindo uma arquitetura padronizada com MobX e Flutter Modular. Automatize a criação de models, repositories, services, stores e pages com um único comando.

## 🚀 Funcionalidades

*   **Geração Rápida:** Crie toda a estrutura de um novo módulo (Model, Repository, Service, Store, Page e Module) instantaneamente.
*   **Arquitetura Consistente:** Mantenha um padrão de código coeso em todo o seu projeto, seguindo as melhores práticas com MobX e Flutter Modular.
*   **Nomenclatura Automática:** Gera automaticamente os nomes de classes e arquivos em PascalCase, camelCase e snake_case a partir de um único input.
*   **Injeção de Dependência Pronta:** O módulo gerado já configura toda a injeção de dependência necessária usando o Flutter Modular.

## 📦 Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/flutter-scaffold-cli.git
    cd flutter-scaffold-cli
    ```

2.  **Ative o CLI globalmente:**
    Você pode usar o `dart pub global activate` para instalar e executar o script de qualquer lugar.
    ```bash
    dart pub global activate --source path .
    ```

## 🛠 Como Usar

Após a instalação, execute o comando `fscaffold` seguido do nome do módulo que deseja criar.

```bash
# Sintaxe básica
fscaffold --name <nome_do_modulo>

# Exemplos
fscaffold --name user
fscaffold -n product
fscaffold -n shopping_cart
