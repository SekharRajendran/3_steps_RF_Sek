ReadMe Document for ‘Three Steps to Simulate Wireless Transceivers with MATLAB’  

 

Webinar abstract: 

Learn three simple steps to design RF transceivers, integrate them in your existing MATLAB code, and perform system-level simulation. With this new approach, you can directly integrate RF models in MATLAB for the simulation of digital communication (5G, WLAN, etc.) or radar systems. 

Practical examples will demonstrate how to perform RF budget analysis and estimate the impact of S-parameters, nonlinearity, and noise. You will see how to customize your RF model to include effects such as impedance mismatches, saturation, and finite isolation. 

You can add analog/digital data converters and control logic to the RF transceiver and develop innovative architectures. With this new methodology, you can simulate the entire system in MATLAB together with digital signal processing algorithms. 

Dependencies: 

MATLAB ,  

Simulink, 

Antenna Toolbox, 

RF Blockset, 

5G Toolbox 

Demo Example Walkthrough: 

The intent of document is to guide MATLAB users to try the MATLAB codes and Simulink  models   

 

Example 1: 

Once the files have been downloaded, navigate to the proper MATLAB working directory (filename Intro_Demo) and you will want to start by running the code with the filename, 

EVMMeasure5G_01.m 

This code is a slightly modified version of the code found in the example found in this link.  

https://www.mathworks.com/help/5g/ug/evm-measurement-of-5g-nr-pdsch-waveforms.html 

This is an example that shows how to measure the error vector magnitude (EVM) of NR test model (NR-TM) or fixed reference channel (FRC) waveforms. The example also shows how to add impairments including phase noise and memoryless nonlinearity. This is a baseband level simulation.  

Example  2: 

The spectrum observed after running the code mentioned above (EVMMeasure5G_01.m) is limited to the bandwidth of the envelope. Hence we are increasing the simulation bandwidth by adding an envelope filter. This code can be accessed from the following filename  

EVMMeasure5G_02.m 

We can observe the out of band effects after running the code above. 

Increasing the RF system Fidelity : starting point 

Open the RF Budget Analyzer from the apps.  You can access this from the MATLAB window by clicking  on APPS tab then scroll to the Signal Processing and Communication Apps. Load the file examplebudgetmodel.mat from the Budget Analyzer app. You can play with the app here. The harmonic balance analysis done on this cascaded model is already saved here. 

You can export the RFbudget object from this app in four different ways. The MATLAB workspace export can be done by clicking MATLAB workspace as shown in the image below: 

 

 

 

Type     >>    rfb    on the MATLAB command window to see details of the rfb object. 

You can make this object into an RF system object using the following command  

 

 

This system object can be added to your existing EVM evaluation model . The modified code can be found with filename  

EVMMeasure5G_03.m 

(please enable or disable line 25 of the code is you have loaded the budget object before) 

 

Expanding the RF system model beyond budget analysis: RF blockset 

You can open the system object using Simulink (with RF Blockset support) using the code  

>> open_system(rfTransmitter) 

 

This opens the Simulink window input and output port configurations preset. You can expand your model, add impairments and algorithm. Save or export it back to the workspace. 

 

The capabilities of RF Blockset was only briefly introduced in the presentation. Please visit the RFblockset examples in the link below to see different use cases : 

https://www.mathworks.com/help/simrf/examples.html?s_tid=CRUX_topnav 

 

Bonus codes : 

Circuit envelope models of a Direct conversion and Low IF receiver can also be found in the Demo folder. 
