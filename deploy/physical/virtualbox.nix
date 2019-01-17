{
  # all in one server
  desktop =
    { config, pkgs, ... }:
    { deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 1536; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
    };
}
