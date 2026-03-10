#!/bin/bash

# 1. Use o caminho absoluto real para evitar erros de expansão
WALL_DIR="/home/hezrai/Pictures"

# Verificação de segurança: Se a pasta não existir, avisa no log
if [ ! -d "$WALL_DIR" ]; then
    echo "Erro: Pasta $WALL_DIR não encontrada!" > /tmp/wall-log.txt
    exit 1
fi

# 2. Seleção (Removi o -maxdepth 1 temporariamente para testar se ele acha algo)
# O "2>/dev/null" esconde erros de permissão de pastas do sistema
SELECTION=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) 2>/dev/null | fzf --prompt="󰸉 Escolha o Wallpaper: " --height=40% --reverse)

# 3. Execução
if [ -n "$SELECTION" ]; then
    # Log para debug
    echo "Imagem selecionada: $SELECTION" > /tmp/wall-log.txt
    
    # Chamada do seu script de aplicação
    # Importante: O wal-set.sh DEVE ter o "export PATH" no topo!
    bash "$HOME/.local/bin/wal-set.sh" "$SELECTION" >> /tmp/wall-log.txt 2>&1
fi
