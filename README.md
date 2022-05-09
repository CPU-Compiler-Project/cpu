Compatible with the Xilinx Vivado version 2018.2

Go to Xilinx Vivado in `Window > TCL Console` and go to this directory.
```sh
cd <your/directory/containing/the/repo>
```

Generate the project.
```sh
source build.tcl
```

---

Save the HDL sources in `src/hdl`.

When you edit the project structure, go to `File > Project > Write Tcl...`, uncheck all the checkboxes and save the new `build.tcl`.