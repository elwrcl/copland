{ ... }:

{
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:X:X:X"; # TODO
    nvidiaBusId = "PCI:X:X:X"; # TODO
  };
}
