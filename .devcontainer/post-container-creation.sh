#!/bin/bash

cat <<EOF >> ~/.bashrc
eval "\$(uv generate-shell-completion bash)"
eval "\$(deno completions bash)"
export UV_LINK_MODE=copy
EOF

echo "Post-installation script completed."
