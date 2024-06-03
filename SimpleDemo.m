load RFBudgetObject;
rfb
rfs = rfsystem(rfb)
rfs.SampleTime = 1e-6;
%%
time = (1:10000)'*1e-6;
in = 1e-2*sin(2*pi*1e64*time);
out = rfs(in);
plot(time, in, time, out);
%%
load RFReceiverDirectConversion;
rfb
%%
rfs = rfsystem(rfb)
rfs.ModelName = 'ReceiverDirectConversion';
open_system(rfs);
%%
time = (1:10000)'/80e6;
in = 6e-4*complexSine(time,[10e6 12e6]);
[I, Q] = rfs(in);
out = complex(I,Q);
%%
SpectAnalyzer = dsp.SpectrumAnalyzer;
SpectAnalyzer.SampleRate = 80e6;
SpectAnalyzer.ShowLegend = true;
SpectAnalyzer.ChannelNames = {'IN', 'OUT'};
SpectAnalyzer.RBWSource ="Property";
SpectAnalyzer.RBW = 1e5;
SpectAnalyzer.SpectralAverages = 8;
SpectAnalyzer([in out]);
%%
load RFReceiverLowIF;
rfb
%%
rfs = rfsystem(rfb)
rfs.SampleTime = 1/50e6;
rfs.ModelName = 'ReceiverLowIF';
open_system(rfs);
%%
rfs.InputFrequency = 2.4*1e9;
open_system(rfs);
%%
time = (1:10000)'/50e6;
in = 6e-4*complexSine(time,5e6);
out = rfs(in);
%%
SpectAnalyzer = dsp.SpectrumAnalyzer;
SpectAnalyzer.SampleRate = 50e6;
SpectAnalyzer.ShowLegend = true;
SpectAnalyzer.RBWSource ="Property";
SpectAnalyzer.RBW = 1e5;
SpectAnalyzer.SpectralAverages = 8;
SpectAnalyzer(out);
%%
release(rfs);
rfs.InputFrequency = [2.4, 2.5]*1e9;
%%
in = 6e-4*complexSine(time,5e6);
Image = 1e-6*complexSine(time, 7e6);
out = rfs([in Image]);
%%
SpectAnalyzer = dsp.SpectrumAnalyzer;
SpectAnalyzer.SampleRate = 50e6;
SpectAnalyzer.ShowLegend = true;
SpectAnalyzer.RBWSource ="Property";
SpectAnalyzer.RBW = 1e5;
SpectAnalyzer.SpectralAverages = 8;
SpectAnalyzer(out);