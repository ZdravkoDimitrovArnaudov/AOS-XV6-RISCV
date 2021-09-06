#
# Non pre-installed version for Advanced Operating Systems UC
#

Vagrant.configure("2") do |config|

    config.vm.box = "debian/bullseye64"

    # synced folder
    config.vm.synced_folder '.', '/aosuc'

    # disable default synced folder
    config.vm.synced_folder '.', '/vagrant', disabled: true

    # install packages (>1GB)
    config.vm.provision 'shell', inline: <<-EOS
    apt-get update && apt-get install -y \
    gcc git qemu-system-i386 gdb make
    EOS

end