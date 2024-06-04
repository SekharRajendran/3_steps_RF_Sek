[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=SekharRajendran/3_steps_RF_Sek)

# Three Steps to Simulate Wireless Transceivers with MATLAB

## Abstract
Learn three simple steps to design RF transceivers, integrate them into your existing MATLAB code, and perform system-level simulation. This approach allows you to directly integrate RF models in MATLAB for simulating digital communication systems (5G, WLAN, etc.) or radar systems.

Practical examples will demonstrate how to perform RF budget analysis and estimate the impact of S-parameters, nonlinearity, and noise. Learn how to customize your RF model to include effects such as impedance mismatches, saturation, and finite isolation.

Additionally, you can add analog/digital data converters and control logic to the RF transceiver and develop innovative architectures. This methodology enables you to simulate the entire system in MATLAB along with digital signal processing algorithms.

## Dependencies
- MATLAB
- Simulink
- Antenna Toolbox
- RF Blockset
- 5G Toolbox

## Demo Example Walkthrough
The intent of this document is to guide MATLAB users to try the MATLAB codes and Simulink models.

### Example 1:
After downloading the files, navigate to the MATLAB working directory (`Intro_Demo`) and run the code with the filename `EVMMeasure5G_01.m`. This code measures the error vector magnitude (EVM) of NR test model (NR-TM) or fixed reference channel (FRC) waveforms, including phase noise and memoryless nonlinearity at the baseband level. 
[Example Link](https://www.mathworks.com/help/5g/ug/evm-measurement-of-5g-nr-pdsch-waveforms.html)

### Example 2:
Run the code `EVMMeasure5G_02.m` to observe out-of-band effects, which includes increasing the simulation bandwidth by adding an envelope filter.

### Increasing the RF System Fidelity: Starting Point
1. Open the RF Budget Analyzer from the MATLAB APPS tab under Signal Processing and Communication Apps.
2. Load the file `examplebudgetmodel.mat` from the Budget Analyzer app. 
3. You can export the `RFbudget` object from this app in four different ways. To export to the MATLAB workspace, click on "MATLAB workspace".
4. Type `>> rfb` in the MATLAB command window to see details of the `rfb` object.
5. Make this object into an RF system object using the command provided in the `EVMMeasure5G_03.m` file (enable or disable line 25 as necessary).

### Expanding the RF System Model Beyond Budget Analysis: RF Blockset
Use the command `>> open_system(rfTransmitter)` to open the Simulink window with input and output port configurations preset. Expand your model, add impairments, and algorithms. Save or export it back to the workspace.

Explore the RF Blockset further with examples provided at the [RF Blockset Examples](https://www.mathworks.com/help/simrf/examples.html?s_tid=CRUX_topnav).

## Bonus Codes
Circuit envelope models of a Direct Conversion and Low IF Receiver can also be found in the Demo folder.
