
sim = figure;
ctrl = figure;


kSlider = uicontrol('parent', ctrl, 'style', 'slider', 'units', 'normalized', ...
                    'position', [0.01 0.01 0.95 0.05], ...
                    'min', -10, ...
                    'max', 20);

x = 0:0.01:10;
while 1
    figure(sim)
    k = get(kSlider, 'value');
    plot(k*sin(x) + randn(size(x))*0.1)
    drawnow;
end

f = figure;
xs = uicontrol('parent',f,'units','normalized','style','slider', ...       
        'position', [0.01 0.17 0.95 0.05],...
        'min'     , 1,...               
        'max'     , 2,...              
        'value'   , 1,...               
        'callback', @sliderCallback);   
    xLstn = addlistener(xs,'ContinuousValueChange',@sliderCallback);
    annotation('textbox',[0.96 0.18 0.2 0.05], 'string', '$x_0$', ...
               'edgecolor', 'none', 'color', 'g', 'fontsize', 20, ...
               'interpreter', 'latex');
           
           
           
CallBack = @(~,b) disp(b.AffectedObject.Value);
F = figure();
H = uicontrol(F,'Style','slider');
addlistener(H, 'Value', 'PostSet',CallBack);

close all
x = 0:1:100;
y = -x.*(x-20).*(x-60).*exp(-x/5);
plot(x,y)


f = figure;
c = uicontrol(f,'Style','popupmenu');
c.Position = [20 75 60 20];
c.String = {'Celsius','Kelvin','Fahrenheit'};
%c.Callback = @selection;

close all;
x = linspace(0,100,1000);
y = 2./(1+exp((x-20)/2))-1;
y = sin(x/5).*exp(-sqrt(x));
plot(x,y)
