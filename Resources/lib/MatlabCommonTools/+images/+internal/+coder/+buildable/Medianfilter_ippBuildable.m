classdef Medianfilter_ippBuildable < coder.ExternalDependency %#codegen
    %MEDIANFILTER_IPPBUILDABLE - encapsulate ippmedianfilter implementation 
    %library
    
    % Copyright 2013-2016 The MathWorks, Inc.
    
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'Medianfilter_ippBuildable';
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

            libstdcpp = [];
            % include libstdc++.so.6 on linux
            if strcmp(arch,'glnxa64')
                libstdcpp = strcat(sysOSArch,{'libstdc++.so.6'});
            end

            switch arch
                case {'win32','win64'}                    
                    libDir        = images.internal.getImportLibDirName(context);
                    linkLibPath   = fullfile(matlabroot,'extern','lib',arch,libDir);
                    linkFiles     = {'libmwippmedianfilter'}; %#ok<*EMCA>
                    linkFiles     = strcat(linkFiles, linkLibExt);
                    
                    nonBuildFiles = {'libmwippmedianfilter','libmwipp'};
                    nonBuildFiles = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles = strcat(binArch, nonBuildFiles);                    
                    
                case {'glnxa64','maci64'}                    
                    linkFiles     = {'mwippmedianfilter','mwipp'};

                    nonBuildFiles = {'libmwippmedianfilter','libmwipp'};
                    nonBuildFiles = strcat(nonBuildFiles, execLibExt);
                    nonBuildFiles = strcat(binArch, nonBuildFiles);
                                        
                otherwise
                    % unsupported
                    assert(false,[arch ' operating system not supported']);
            end
            
            if coder.internal.hostSupportsGccLikeSysLibs()
                buildInfo.addSysLibs(linkFiles, linkLibPath, group);
            else
                linkPriority    = images.internal.coder.buildable.getLinkPriority('ipp');
                linkPrecompiled = true;
                linkLinkonly    = true;
                buildInfo.addLinkObjects(linkFiles,linkLibPath,linkPriority,...
                                         linkPrecompiled,linkLinkonly,group);
            end
            
            % Non-build files
            nonBuildFiles = [nonBuildFiles libstdcpp];
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
            
        end
        
        
        function outputImage = medianfilter_ippCore(fcnName, inputImage, inputSize, maskSize, outputImage)
            coder.inline('always');
            coder.cinclude('libmwippmedianfilter.h');
            coder.ceval(fcnName, ...
                coder.rref(inputImage),  ...
                coder.rref(inputSize), ...
                coder.rref(maskSize), ...
                coder.ref(outputImage));
        end
        
    end
    
end
