classdef IppfilterBuildable < coder.ExternalDependency %#codegen
    %IPPFILTERBUILDABLE - encapsulate ippfilter implementation library
    
    % Copyright 2013-2016 The MathWorks, Inc.
    
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'IppfilterBuildable';
        end
        
        function b = isSupportedContext(context)
            b = context.isMatlabHostTarget();
        end
        
        function updateBuildInfo(buildInfo,context)
            % File extensions
            [linkLibPath, linkLibExt, execLibExt] = ...
                context.getStdLibInfo();
            group = 'BlockModules';
            
            % Header paths
            buildInfo.addIncludePaths(fullfile(matlabroot,'extern','include'));
            
            % Platform specific link and non-build files
            arch      = computer('arch');
            binArch   = fullfile(matlabroot,'bin',arch,filesep);
            sysOSArch = fullfile(matlabroot,'sys','os',arch,filesep);

            % include libstdc++.so.6 on linux
            libstdcpp = [];

            switch arch
                case {'win32','win64'}                    
                    libDir        = images.internal.getImportLibDirName(context);
                    linkLibPath   = fullfile(matlabroot,'extern','lib',arch,libDir);
                    linkFiles     = {'libmwippfilter'}; %#ok<*EMCA>
                    linkFiles     = strcat(linkFiles, linkLibExt);
                    
                    nonBuildFiles = {'libmwippfilter','tbb','libmwipp'};
                    nonBuildFiles = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles = strcat(binArch, nonBuildFiles);                    
                    
                case 'glnxa64'                    
                    libstdcpp     = strcat(sysOSArch,{'libstdc++.so.6'});

                    linkFiles     = {'mwippfilter','mwipp'};

                    nonBuildFiles = {'libmwippfilter'};
                    nonBuildFiles = strcat(nonBuildFiles, execLibExt);

                    nonBuildFiles{end+1} = 'libtbb.so.2';
                    nonBuildFiles{end+1} = 'libtbbmalloc.so.2';
                    nonBuildFiles{end+1} =  strcat('libmwipp', execLibExt);
                    
                    nonBuildFiles = strcat(binArch, nonBuildFiles);
                    
               case 'maci64'                    
                    linkFiles     = {'mwippfilter','mwipp'};

                    nonBuildFiles = {'libmwippfilter','libtbb', 'libtbbmalloc','libmwipp'};
                    nonBuildFiles = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles = strcat(binArch, nonBuildFiles);
                                      
                otherwise
                    % unsupported
                    assert(false,[ arch ' operating system not supported']);
            end
            if coder.internal.hostSupportsGccLikeSysLibs()
                buildInfo.addSysLibs(linkFiles, linkLibPath, group);
            else
                linkPriority    = images.internal.coder.buildable.getLinkPriority('tbb');
                linkPrecompiled = true;
                linkLinkonly    = true;
                buildInfo.addLinkObjects(linkFiles,linkLibPath,linkPriority,...
                                         linkPrecompiled,linkLinkonly,group);
            end
            
            % Non-build files
            nonBuildFiles = [nonBuildFiles libstdcpp];
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
            
        end
        
        
        function out = ippfiltercore_uint8(a, out, outSize, numPadDims, padSize, kernel, kernelSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwippfilter.h');
            coder.ceval('ippfilter_uint8',...
                coder.rref(a),...
                coder.ref(out),...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(kernel),...
                coder.rref(kernelSize),...
                convMode);
        end
        
        function out = ippfiltercore_uint16(a, out, outSize, numPadDims, padSize, kernel, kernelSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwippfilter.h');
            coder.ceval('ippfilter_uint16',...
                coder.rref(a),...
                coder.ref(out),...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(kernel),...
                coder.rref(kernelSize),...
                convMode);
        end
        
        
        function out = ippfiltercore_int16(a, out, outSize, numPadDims, padSize, kernel, kernelSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwippfilter.h');
            coder.ceval('ippfilter_int16',...
                coder.rref(a),...
                coder.ref(out),...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(kernel),...
                coder.rref(kernelSize),...
                convMode);
        end
        
        
        function out = ippfiltercore_single(a, out, outSize, numPadDims, padSize, kernel, kernelSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwippfilter.h');
            coder.ceval('ippfilter_real32',...
               coder.rref(a),...
                coder.ref(out),...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(kernel),...
                coder.rref(kernelSize),...
                convMode);
        end
        
        
        function out = ippfiltercore_double(a, out, outSize, numPadDims, padSize, kernel, kernelSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwippfilter.h');
            coder.ceval('ippfilter_real64',...
                coder.rref(a),...
                coder.ref(out),...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(kernel),...
                coder.rref(kernelSize),...
                convMode);
        end
        
        
    end
    
    
end
