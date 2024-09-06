#!/bin/sh

# Verifica se o nome de usuário foi fornecido como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 nome_usuario"
    exit 1
fi

u=$1

# Função para verificar se o usuário existe
verifica_usuario_existe() {
    if id "$u" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Função para verificar se o usuário está logado
verifica_usuario_logado() {
    who | grep -w "$u" >/dev/null 2>&1
}

# Função para listar arquivos da home do usuário
lista_arquivos_home() {
    if [ -d "/home/$u" ]; then
        ls "/home/$u"
    else
        echo "Diretório /home/$u não encontrado."
    fi
}

while true; do
    # Verifica se o usuário existe
    verifica_usuario_existe
    if [ $? -ne 0 ]; then
        echo "Usuário $u não encontrado."
        exit 1
    fi

    # Exibe o menu
    echo "Escolha uma opção:"
    echo "1 --> Verifica se o usuário existe"
    echo "2 --> Verifica se o usuário está logado na máquina"
    echo "3 --> Lista os arquivos da pasta home do usuário"
    echo "4 --> Sair"
    read -p "Opção: " op

    case $op in
        1)
            echo "O usuário $u existe."
            ;;
        2)
            if verifica_usuario_logado; then
                echo "O usuário $u está logado na máquina."
            else
                echo "O usuário $u não está logado na máquina."
            fi
            ;;
        3)
            lista_arquivos_home
            ;;
        4)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done

