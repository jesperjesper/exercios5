#!/bin/bash

# .cloudrc source
# source .cloudrc

# Create VM
create_vm() {
    echo "Creating virtual machine..."
    terraform init
    terraform apply -auto-approve
    echo "Virtual machine created successfully!"
}

# Destroy VM
destroy_vm() {
    echo "Destroying virtual machine..."
    terraform init
    terraform destroy -auto-approve
    echo "Virtual machine destroyed successfully!"
}

# Menu options
PS3="Please enter your choice: "
options=("Create Virtual Machine" "Destroy Virtual Machine" "Quit")

# Menu loop
select menu in "${options[@]}"
do
    case $menu in
        "Create Virtual Machine")
            create_vm
            ;;
        "Destroy Virtual Machine")
            destroy_vm
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done

echo "Goodbye!"
