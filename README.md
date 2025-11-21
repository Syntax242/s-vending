# 🥤 QBCore Advanced Vending Machine

A fully featured and customizable vending machine system for QBCore servers.  
This script enhances roleplay immersion by allowing players to interact with vending machines, purchase items, and trigger animations while maintaining an automated stock and logging system.
For bug reports, support inquiries, or custom feature integrations, please reach out via Discord: **syntax_2024**

---

## 🚀 Features

- **Multiple machine support**  
  Each vending machine model can be linked to a different item group.

- **Per-machine stock system**  
  Each machine has its own stock count, automatically refreshed on a configurable timer.

- **Smooth interaction flow**  
  qb-target interaction, ox_lib menus, and progress animations.

- **Advanced Discord logging**  
  Logs every purchase with:
  - Player identity 
  - Character name
  - Item name
  - Amount
  - Price paid
  - Purchase location 

- **Admin system**
  - Optional admin restock command
  - Permission check via QBCore group (admin/god)

- **Highly configurable**
  - Custom item groups
  - Machine model mapping
  - Discord logging control
  - Customizable refresh time

- **Optimized**
  Lightweight and performance-safe on both server and client.

---

## 📦 Dependencies

The following resources are required:

| Dependency | Link |
|-----------|------|
| **QBCore Framework** | https://github.com/qbcore-framework/qb-core |
| **qb-target** | https://github.com/qbcore-framework/qb-target |
| **ox_lib** | https://github.com/overextended/ox_lib |
| **ox_inventory** | https://github.com/overextended/ox_inventory |

All dependencies must be installed and started **before** this script.

---

## 🛠️ Installation

1. Drag and drop the resource into your server's `resources` folder.  
2. Make sure all dependencies are installed and running.  
3. Add the resource to your `server.cfg`:
4. Configure the script inside `config.lua` to your needs:
   - Item groups  
   - Machine models  
   - Restock timer  
   - Discord webhook  
   - Logging options  
   - Admin command  

5. Restart the server.

Developed by Syntax

