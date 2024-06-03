%% EVM Measurement of 5G NR PDSCH Waveforms
% Copyright 2019-2021 The MathWorks, Inc.
%% Simulation parameters
rc = "NR-FR1-TM3.1"; % Reference channel(NR-TM or FRC)
bw = "100MHz"; % Channel bandwidth
scs = "30kHz"; % Subcarrier spacing
dm = "FDD"; % Duplexing mode
%%
targetRNTIs = [];
displayEVM = true;
plotEVM = true;
evm3GPP = true;
%% Create waveform generator object and generate the 5G waveform
tmwavegen = hNRReferenceWaveformGenerator(rc,bw,scs,dm);
[txWaveform,tmwaveinfo,resourcesinfo] = generateWaveform(tmwavegen,...
    tmwavegen.Config.NumSubframes);
%% Interpolate input signal
I = 5; D = 1; filtLength = 60;
FIR_tx = designMultirateFIR(I,D,filtLength,180,'SystemObject',true);
txWaveform = FIR_tx(txWaveform);
pin = 20*log10(rms(txWaveform/sqrt(50)))+30                                %#ok
%% Simple RF model 
Gain = 20; %dB
OIP3 = 10; %dBm
a = 10^(Gain/20);
c = (4/3)*(a^3)/(50*10^((OIP3-30)/20));
rxWaveform = a*txWaveform+c*txWaveform.^3;
%% Plot input/output spectrum
SpectAnalyzer = dsp.SpectrumAnalyzer;
SpectAnalyzer.SampleRate = tmwaveinfo.Info.SampleRate*5;
SpectAnalyzer.ShowLegend = true;
SpectAnalyzer.ChannelNames = {'IN', 'OUT'};
SpectAnalyzer.RBWSource ="Property";
SpectAnalyzer.RBW = 1e5;
SpectAnalyzer.SpectralAverages = 8;
SpectAnalyzer.ReferenceLoad = 50;
SpectAnalyzer([txWaveform rxWaveform]);
pout = 20*log10(rms(rxWaveform/sqrt(50)))+30                               %#ok
%% Decimate output signal
FIR_rx = designMultirateFIR(1,5,filtLength,180,'SystemObject',true);
rxWaveform = FIR_rx(rxWaveform); 
%% Perform EVM Measurements
% * Synchronization using the DM-RS over one frame for FDD 
% * OFDM demodulation of the received waveform
% * Channel estimation
% * Equalization
% * PDSCH EVM computation 
cfg = struct();
cfg.Evm3GPP = evm3GPP;
cfg.TargetRNTIs = targetRNTIs;
cfg.PlotEVM = plotEVM;
cfg.DisplayEVM = displayEVM;
cfg.Label = tmwavegen.ConfiguredModel{1};
[evmGrid,eqSym,refSym,plots] = hNRPDSCHEVM(tmwavegen.Config,rxWaveform,...
    cfg,resourcesinfo.WaveformResources);                                