#!/bin/sh

# Verifica se o argumento de comando foi fornecido
if [ $# -lt 1 ]; then
    echo "Uso: Para contar linhas em branco $0 [-c] arquivo"
    echo "Uso: Para apagra linhas em branco $0 arquivo"
    exit 1
fi

# Define as variáveis para os argumentos
f=""
c=0

# Processa as opções e o arquivo
while getopts ":c" opt; do
    case $opt in
        c)
            c=1
            ;;
        \?)
            echo "Opção inválida: -$OPTARG" >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

# Obtém o arquivo
f=$1

# Verifica se o arquivo foi especificado e se existe
if [ -z "$f" ]; then
    echo "Erro: Arquivo não especificado."
    exit 1
elif [ ! -f "$f" ]; then
    echo "Erro: O arquivo $f não existe."
    exit 1
fi

# Contador de linhas em branco
conta_brancos() {
    l=0
    while IFS= read -r linha; do
        if [ -z "$linha" ]; then
            l=$((l + 1))
        fi
    done < "$f"
    echo "Número de linhas em branco: $l"
}

# Remove linhas em branco usando tr
remove_brancos() {
    # Utiliza tr para remover as linhas em branco e compactar as quebras de linha
    tr -s '\n' < "$f" | tr -d '\r' > "${f}.temp"
    mv "${f}.temp" "$f"
    echo "Linhas em branco removidas."
}

# Executa a ação com base na opção
if [ $c -eq 1 ]; then
    conta_brancos
else
    remove_brancos
fi

