module tt_um_equipo7 (
    input  wire clk,              // Clock del sistema
    input  wire [7:0] ui_in,      // Entradas GPIO (reset, start, rx, info_in[4:0])
    output wire [7:0] uo_out,     // Salida del receptor UART
    input  wire [7:0] uio_in,     // No utilizados
    output wire [7:0] uio_out,    // No utilizados
    output wire [7:0] uio_oe,     // No utilizados
    input  wire ena               // Enable (no utilizado aquí)
);

    // Mapeo de señales
    wire reset      = ui_in[0];
    wire start      = ui_in[1];
    wire rx         = ui_in[2];
    wire [4:0] data = ui_in[7:3]; // Solo 5 bits (por límite de GPIOs)

    // Completamos a 8 bits para info_in del UART
    wire [7:0] data_in = {3'b000, data};
    wire [7:0] data_out;
    wire terminado;

    // Instanciamos tu UART
    UARTComplete uart_inst (
        .clockUart(clk),
        .resetUart(reset),
        .StartUart(start),
        .info_in_Uart(data_in),
        .info_out_Uart(data_out),
        .TerminadoUart(terminado)
    );

    // Salida
    assign uo_out = data_out;

    // Pines no usados
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
 
