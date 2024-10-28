#!/bin/bash

# Make required directories and files for metadata enforcment
make_dirs () {
    mkdir /app/calibre-web-automated/metadata_change_logs
    chown -R abc:abc /app/calibre-web-automated/metadata_change_logs
    mkdir /app/calibre-web-automated/metadata_temp
    chown -R abc:abc /app/calibre-web-automated/metadata_temp
    mkdir /cwa-book-ingest
    chown abc:abc /cwa-book-ingest
    mkdir /calibre-library
    chown -R abc:abc /calibre-library
}

# Change ownership & permissions as required
change_script_permissions () {
    chmod +x /app/calibre-web-automated/scripts/check-cwa-services.sh
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-ingest-service/run
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-init-remove-locks/run
    chmod +x /etc/s6-overlay/s6-rc.d/metadata-change-detector/run
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-set-perms/run
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-auto-library/run
    chmod +x /etc/s6-overlay/s6-rc.d/cwa-auto-zipper/run
    chmod 775 /app/calibre-web/cps/editbooks.py
    chmod 775 /app/calibre-web/cps/admin.py
}

# Add aliases to .bashrc
add_aliases () {
    echo "" | cat >> ~/.bashrc
    echo "# Calibre-Web Automated Aliases" | cat >> ~/.bashrc
    echo "alias cwa-check='bash /app/calibre-web-automated/scripts/check-cwa-services.sh'" | cat >> ~/.bashrc
    echo "alias cwa-change-dirs='nano /app/calibre-web-automated/dirs.json'" | cat >> ~/.bashrc
    
    echo "cover-enforcer () {" | cat >> ~/.bashrc
    echo '    python3 /app/calibre-web-automated/scripts/cover-enforcer.py "$@"' | cat >> ~/.bashrc
    echo "}" | cat >> ~/.bashrc
    
    echo "convert-library () {" | cat >> ~/.bashrc
    echo '    python3 /app/calibre-web-automated/scripts/convert-library.py "$@"' | cat >> ~/.bashrc
    echo "}" | cat >> ~/.bashrc
    
    source ~/.bashrc
}

echo "Running docker image setup script..."
make_dirs
change_script_permissions
add_aliases