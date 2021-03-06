function vw=makeSliceButtons(vw)
%
% vw=makeSliceButtons(vw)
%
% Installs push buttons that set curSlice.
% This is used for the inplane view only.
%
% djh, 1/97
% bw, 12.08.00.  For more than 12 planes, we put up a slider
% instead of the individual buttons
%

if ~strcmp('Inplane',vw.viewType)
   error('makeSliceButtons:  Only called for INPLANE');
end

nSlices = numSlices(vw);

if nSlices <= 12
   % sliceButtons all placed individually on the left.
   width = .07; height = .05; left = .01;
   for z=1:nSlices
      bot=z*.8/nSlices;
      % Callback:
      %   selectButton(vw.ui.sliceButtons,z);
      %   vw=refreshScreen(vw);
      callbackStr = ...
         ['selectButton(',vw.name,'.ui.sliceButtons,',num2str(z),'); ',...
            vw.name,'=refreshScreen(',vw.name,');'];
      vw.ui.sliceButtons(z) = ...
         uicontrol('Style','radiobutton',...
         'String',int2str(z),...
         'Units','normalized',...
         'Position',[left,bot,width,height],...
         'Callback', callbackStr);
   end
   
else
   % Use a slider and next/prev buttons to move through the slices
   % This is the position of the number field
   
   % Callback:
   %   sliceNum=str2num(get(vw.ui.sliceNumFields(1),'String'));
   %   sliceNum=clip(sliceNum,1,numSlices(vw));
   %   set(vw.ui.sliceNumFields,'String',num2str(sliceNum));
   %   clear sliceNum dims;
   %   vw=refreshScreen(vw);
   callbackStr = ...
      ['sliceNum=str2num(get(',vw.name,'.ui.sliceNumFields(1),''String'')); '...
         'sliceNum=clip(sliceNum,1,numSlices(',vw.name,')); '...
         'set(',vw.name,'.ui.sliceNumFields,''String'',num2str(sliceNum)); '...
         'clear sliceNum volSize; ',...
         vw.name,'=refreshScreen(',vw.name,');'];
   %
   left = .01; width = .07; height = .05; bot= .5;
   vw.ui.sliceNumFields = ...
      uicontrol('Style','edit',...
      'BackgroundColor',[1 1 1],...
      'String',num2str(1),...
      'Units','normalized',...
      'Position',[left,bot,width,height],...
      'Callback', callbackStr);
   
   
   % Prev button
   % Callback:
   %   sliceNum=viewGet(vw, 'Current Slice')-1;
   %   setCurSlice(vw,sliceNum);
   %   clear sliceNum;
   %   vw=refreshScreen(vw);
   
   callbackStr = ...
      ['sliceNum=viewGet(',vw.name,', ''Current Slice'')-1; '...        
         'vw = viewSet(',vw.name,', ''Current Slice'',', num2str(sliceNum),'); '...
         'clear sliceNum; ',...
         vw.name,'=refreshScreen(',vw.name,');'];
   bot= .45;
   vw.ui.previousBtn= ...
      uicontrol('Style','pushbutton',...
      'String','<<',...
      'Units','normalized',... 
      'Position',[left,bot,width,height], ...
      'Callback', callbackStr);
   
   % Next button
   % Callback:
   %   sliceNum=viewGet(vw, 'Current Slice')+1;
   %   viewSet(vw, 'Current Slice', sliceNum);
   %   clear sliceNum;
   %   vw=refreshScreen(vw);
   callbackStr = ...
      ['sliceNum=viewGet(',vw.name,', ''Current Slice'')+1; '...
      'vw = viewSet(',vw.name,',''Current Slice'',', num2str(sliceNum),'); '...
      'clear sliceNum; ',...
         vw.name,'=refreshScreen(',vw.name,');'];
   
   bot= .55;
   vw.ui.nextBtn= ...
      uicontrol('Style','pushbutton',...
      'String','>>',...
      'Units','normalized',... 
      'Position',[left,bot,width,height], ...
      'Callback', callbackStr);
   
end

return;
