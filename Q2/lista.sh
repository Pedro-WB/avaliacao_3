#!/bin/sh

# Verifica se a pasta foi fornecida como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 /caminho/para/pasta."
    exit 1
fi

# Pasta fornecida como argumento
p=$1

# Verifica se a pasta existe
if [ ! -d "$p" ]; then
    echo "A pasta $p não existe."
    exit 1
fi

# Função para listar apenas diretórios
lista_diretorios() {
    for i in "$p"/*; do
        if [ -d "$i" ]; then
            echo "$(basename "$i")"
        fi
    done
}

# Função para listar apenas executáveis
lista_executaveis() {
    for i in "$p"/*; do
        if [ -x "$i" ] && [ ! -d "$i" ]; then
            echo "$(basename "$i")"
        fi
    done
}

# Função para listar apenas scripts shell
lista_scripts_shell() {
    for i in "$p"/*.sh; do
        if [ -x "$i" ] && [ ! -d "$i" ]; then
            echo "$(basename "$i")"
        fi
    done
}

# Menu e escolha da opção
while true; do
    echo "Escolha uma opção:"
    echo "a --> Liste apenas os diretórios de uma pasta"
    echo "b --> Liste apenas os executáveis"
    echo "c --> Liste apenas os scripts shell"
    echo "d --> Sair"
    read -p "Opção: " op

    case $op in
        a)
            lista_diretorios
            ;;
        b)
            lista_executaveis
            ;;
        c)
            lista_scripts_shell
            ;;
        d)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done

