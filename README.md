# afg-3000-series
A MATLAB wrapper library for controlling a Tektronix 3000 series AFG via serial connection.

## Prerequisites

First, install NI Visa from the national instruments website. Even though tektronix make a version of Visa, testing showed the NI one to work better in this application.

Second, install the instrument control toolbox for MATLAB from the add-on installer.

## Description of functions

### tek_afg_set_burst(freq, amp, Ncycles)

Use this function to set a simple burst with a specified frequency, amplitude and number of cycles.

### tek_afg_set_arb(t, V)

Takes a time array, t, and a voltage array, V, and configures the function generator to output the specified waveform.

### tek_afg_set_f(freq)

Sets the frequency of the function generator leaving all other parameters unchanged. WARNING - this function has not been tested yet, please request that this code is updated if you test it and need to change something.

### test.m

A simple script which calls tek_afg_set_burst and cycles through 1-50 cycles in burst mode. You can use this function to ensure that you have the drivers configured correctly, and use it as an example of how to use the function.