#!/bin/bash

# Exit on errors
set -e

echo "🌟 Starting Ansible Bootstrap Process..."

# Detect package manager
if command -v apt >/dev/null 2>&1; then
  PACKAGE_MANAGER="apt"
elif command -v dnf >/dev/null 2>&1; then
  PACKAGE_MANAGER="dnf"
else
  echo "❌ Unsupported package manager. Exiting."
  exit 1
fi

echo "📦 Detected package manager: $PACKAGE_MANAGER"

# Install prerequisites based on package manager
if [ "$PACKAGE_MANAGER" = "apt" ]; then
  echo "🔧 Updating apt cache..."
  sudo apt update

  echo "🔧 Installing Python and pip..."
  sudo apt install -y python3 python3-pip

  echo "🔧 Installing Ansible..."
  sudo apt install -y ansible

elif [ "$PACKAGE_MANAGER" = "dnf" ]; then
  echo "🔧 Installing Python and pip..."
  sudo dnf install -y python3 python3-pip

  echo "🔧 Installing Ansible..."
  sudo dnf install -y ansible
fi

# Verify Ansible installation
echo "✅ Verifying Ansible installation..."
if ! command -v ansible >/dev/null 2>&1; then
  echo "❌ Ansible installation failed. Exiting."
  exit 1
fi

ANSIBLE_VERSION=$(ansible --version | head -n 1)
echo "🎉 Ansible installed successfully: $ANSIBLE_VERSION"

# Ensure the playbook exists
if [ ! -f "playbooks/bootstrap.yml" ]; then
  echo "❌ Playbook not found: playbooks/bootstrap.yml"
  echo "Make sure you're in the correct directory and try again."
  exit 1
fi

# Run the main playbook
echo "🚀 Running the main Ansible playbook..."
ansible-playbook playbooks/bootstrap.yml --ask-become-pass
