#!/bin/bash

# MIT License view License on GitHub: https://github.com/karlosvas/warp-customization/LICENSE.md

# Función para mostrar la ayuda
mostrar_ayuda() {
    echo "Uso: $0 [directorio_del_repositorio]"
    echo
    echo "Si no se proporciona un directorio, se usará el directorio actual."
    echo "Opciones:"
    echo "  -h    Mostrar esta ayuda"
    echo "  -v    Mostrar la versión"
    echo "  -l    Selecionar lengua, es o en"
}

show_help() {
    echo "Usage: $0 [repository_directory]"
    echo
    echo "If no directory is provided, the current directory will be used."
    echo "Options:"
    echo "  -h    Show this help message"
    echo "  -v    Show version"
    echo "  -l    Select language, es or en"
}

lang="es"

# Verificar si es español o inglés
# Verify if it is spanish or english
if [ "$lang" == "es" ]; then
    # Español
############################################################################################################
    # Verificar si se proporcionó -h como argumento para la ayuda
    if [ "$1" == "-h" ]; then
        mostrar_ayuda
        exit 0
    elif [ "$1" == "-l" ]; then
        echo "Selecciona tu lengua"
        echo "español o ingles"
        read lengua
        if [ "$lengua" == "es" ]; then
            echo "Idioma cambiado a español"
            lang="es"
            exit 0
        elif [ "$lengua" == "en" ]; then
            echo "Language changed to english"
            lang="en"
            exit 0
        else
            echo "Opción inválida porfavor seleccione es o en"
            exit 1
        fi
    elif [ "$1" == "-v" ]; then
        # Muestra la versión
        echo "ghub v1.0.0"
        exit 0
    fi
############################################################################################################
    # Logica del programa principal
    
    # Verificar si se proporcionó un argumento
    if [ $# -eq 0 ]; then
        # Si no se proporciona un argumento, usar el directorio actual
        repo_dir="."
    else
        # Usar el argumento proporcionado como el directorio del repositorio
        repo_dir=$1
        # Eliminar el prefijo .\ si existe
        # Eliminar el prefijo . si existe
        # Eliminar el sufijo \ si existe
        repo_dir=${repo_dir#.\\}
        repo_dir=${repo_dir#.}
        repo_dir=${repo_dir%\\}
        # Verificar si el directorio proporcionado existe
        # Directorio actual mas el repor dir
        repo_dir=$(pwd)/${repo_dir}
    fi

    # Cambiar al directorio del repositorio
    cd "$repo_dir" || { echo "No se pudo acceder al directorio: $repo_dir"; exit 1; }

    # Obtener la URL del repositorio remoto
    url=$(git config --get remote.origin.url)

    # Verificar si se obtuvo una URL
    if [[ -z $url ]]; then
        echo "No se pudo obtener la URL del repositorio en el directorio: $repo_dir"
        exit 1
    fi

    # Transformar la URL en formato HTTPS si es necesario
    if [[ $url == git@* ]]; then
        url=${url/:/\//}
        url=https://${url/git@/}
        url=${url/.git/}
    fi

    # Mostrar la URL para verificar
    echo "URL del repositorio: $url"

    # Abrir la URL en el navegador, linux o windows o mac
    if command -v xdg-open &> /dev/null; then
        xdg-open $url
    elif command -v start &> /dev/null; then
        start $url
    elif command -v open &> /dev/null; then
        open $url
    else
        echo -e "\e[91mNo se pudo encontrar un comando para abrir el navegador\e[0m"
        echo -e "\e[91mIntentando desde cmd\e[0m\n"
        echo -e "\t ██████╗ ██╗████████╗██╗  ██╗██╗   ██╗██████╗ "
        echo -e "\t██╔════╝ ██║╚══██╔══╝██║  ██║██║   ██║██╔══██╗"
        echo -e "\t██║  ███╗██║   ██║   ███████║██║   ██║██████╔╝"
        echo -e "\t██║   ██║██║   ██║   ██╔══██║██║   ██║██╔══██╗"
        echo -e "\t╚██████╔╝██║   ██║   ██║  ██║╚██████╔╝███████╗"
        echo -e "\t ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
        cmd.exe /c start $url
    fi
elif [ "$lang" == "en" ]; then
    # English
############################################################################################################
    # Check if -h was provided as an argument for help
    if [ "$1" == "-h" ]; then
       # Show help in english
        show_help
        exit 0
    elif [ "$1" == "-l" ]; then
        # Select language
        echo "Select your language"
        echo "es or en"
        read lengua
       if [ "$lengua" == "es" ]; then
            echo "Idioma cambiado a español"
            lang="es"
            exit 0
        elif [ "$lengua" == "en" ]; then
            echo "Language changed to english"
            lang="en"
            exit 0
        else
            echo "Invalid option please select es or en"
            exit 1
        fi
    elif [ "$1" == "-v" ]; then
        # Show version
        echo "ghub v1.0.0"
        exit 0
    fi
############################################################################################################
    # Main program logic

    # Check if an argument was provided
    if [ $# -eq 0 ]; then
        # If no argument is provided, use the current directory
        repo_dir="."
    else
        # Use the provided argument as the repository directory
        repo_dir=$1
        # Check if the provided directory exists
        if [ ! -d "$repo_dir" ]; then
            echo "The specified directory does not exist: $repo_dir"
            exit 1
        fi
    fi

    # Change to the repository directory
    cd "$repo_dir" || { echo "Could not access directory: $repo_dir"; exit 1; }

    # Get the URL of the remote repository
    url=$(git config --get remote.origin.url)

    # Check if a URL was obtained
    if [[ -z $url ]]; then
        echo "Could not get the URL of the repository in the directory: $repo_dir"
        exit 1
    fi

    # Transform the URL into HTTPS format if necessary
    if [[ $url == git@* ]]; then
        url=${url/:/\//}
        url=https://${url/git@/}
        url=${url/.git/}
    fi

    # Show the URL to verify
    echo "Repository URL: $url"

    # Open the URL in the browser
    if command -v xdg-open &> /dev/null; then
        xdg-open $url
    elif command -v open &> /dev/null; then
        open $url
    elif command -v start &> /dev/null; then
        start $url
    else
        echo -e "\e[91mCould not find a command to open the browser\e[0m"
        echo -e "\e[91mTrying from cmd\e[0m\n"
        echo -e "\t ██████╗ ██╗████████╗██╗  ██╗██╗   ██╗██████╗ "
        echo -e "\t██╔════╝ ██║╚══██╔══╝██║  ██║██║   ██║██╔══██╗"
        echo -e "\t██║  ███╗██║   ██║   ███████║██║   ██║██████╔╝"
        echo -e "\t██║   ██║██║   ██║   ██╔══██║██║   ██║██╔══██╗"
        echo -e "\t╚██████╔╝██║   ██║   ██║  ██║╚██████╔╝███████╗"
        echo -e "\t ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
        cmd.exe /c start $url
    fi
    
fi
