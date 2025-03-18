function s = loadMapdt(varargin)
fnG=  "D:\od\OneDrive\matlab\RawData\1T-TaS2(point defect)\Gxy0T.mat";
fngap = "D:\od\OneDrive\matlab\RawData\1T-TaS2(point defect)\Gap0Tpn.mat";
xs = [140 700 770 1500];
ys = [60 680];
switch length(varargin)
    case 0        
        '[1:full 2:stsPossible 3:phase1 4:phase2]'
        '[1:includeG 0:not]'
    case 1
        isContainG = 0;        
    case 2
        isContainG = varargin{2};
end

if length(varargin)>0
    sgap = load(fngap);
    if isContainG == 1
        sG = load(fnG)
    elseif isContainG == 0
        vlist = who("-file",fnG);
        sG = load(fnG,vlist{2:end});        
    end
end
mergestructs = @(x,y) cell2struct([struct2cell(x);struct2cell(y)],[fieldnames(x);fieldnames(y)]);
s = mergestructs(sgap,sG);
switch varargin{1}
    case 1
        idx = 1:length(sG.x);
        idy = 1:length(sG.y);
    case 2
        idx = xs(1):xs(4);
        idy = ys(1):ys(2);
    case 3
        idx = xs(1):xs(2);
        idy = ys(1):ys(2);
    case 4
        idx = xs(3):xs(4);
        idy = ys(1):ys(2);
end
s.Gap0Tn = s.Gap0Tn(idx,idy);
s.Gap0Tp = s.Gap0Tp(idx,idy);
s.ImgFinalZnorm = s.ImgFinalZnorm(idx,idy);
s.x = s.x(idx);
s.y = s.y(idy);
s.Zfinal0T = s.Zfinal0T(idx,idy);
try
    s.Gfinal0T = s.Gfinal0T(idx,idy,:);
end
end