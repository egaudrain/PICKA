classdef ImfilterBuildable < coder.ExternalDependency %#codegen
    %IMFILTERBUILDABLE - encapsulate imfilter implementation library
    
    % Copyright 2013-2016 The MathWorks, Inc.
    
    
    methods (Static)
        
        function name = getDescriptiveName(~)
            name = 'ImfilterBuildable';
        end
         
        function b = isSupportedContext(context)
            b = context.isMatlabHostTarget();
        end
        
        function updateBuildInfo(buildInfo, context)
            % File extensions
            [~, linkLibExt, execLibExt] = ...
                context.getStdLibInfo();
            group = 'BlockModules';
            
            % Header paths
            buildInfo.addIncludePaths(fullfile(matlabroot,'extern','include'));
            
            % Platform specific link and non-build files
            arch      = computer('arch');
            binArch   = fullfile(matlabroot,'bin',arch,filesep);
            sysOSArch = fullfile(matlabroot,'sys','os',arch,filesep);

            libstdcpp = [];
            % include libstdc++.so.6
            if strcmp(arch,'glnxa64')
                libstdcpp = strcat(sysOSArch,{'libstdc++.so.6'});
            end

            switch arch
                case {'win32','win64'}
                    libDir      = images.internal.getImportLibDirName(context);
                    linkLibPath = fullfile(matlabroot,'extern','lib',computer('arch'),libDir);
                    linkFiles   = {'libmwimfilter'}; %#ok<*EMCA>
                    linkFiles   = strcat(linkFiles, linkLibExt);
                    
                case {'glnxa64','maci64'}
                    linkFiles   = {'mwimfilter','mwnhood'};
                    linkLibPath = binArch;
                
                otherwise
                    % unsupported
                    assert(false,[arch ' operating system not supported']);
            end

            if coder.internal.hostSupportsGccLikeSysLibs()
                buildInfo.addSysLibs(linkFiles, linkLibPath, group);
            else
                linkPriority    = '';
                linkPrecompiled = true;
                linkLinkonly    = true;
                buildInfo.addLinkObjects(linkFiles,linkLibPath,linkPriority,...
                                         linkPrecompiled,linkLinkonly,group);
            end
            
            % Non-build files
            nonBuildFiles = {'libmwnhood', 'libmwimfilter'};            
            nonBuildFiles = strcat(binArch,nonBuildFiles, execLibExt);
            nonBuildFiles = [nonBuildFiles libstdcpp];
            buildInfo.addNonBuildFiles(nonBuildFiles,'',group);
                        
        end
        
        
        function out = imfiltercore_logical(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_boolean',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_uint8(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_uint8',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_int8(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_int8',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_uint16(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_uint16',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_int16(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_int16',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_uint32(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_uint32',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_int32(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_int32',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        function out = imfiltercore_single(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_real32',...
               coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
        function out = imfiltercore_double(a, out, nimdims, outSize, numPadDims, padSize, nonZeroKernel, numKernElem, conn, nconnDims, connDims, start, numStartElem, sameSize, convMode)
            coder.inline('always');
            coder.cinclude('libmwimfilter.h');
            coder.ceval('imfilter_real64',...
                coder.rref(a),...
                coder.ref(out),...
                nimdims,...
                coder.rref(outSize),...
                numPadDims,...
                coder.rref(padSize),...
                coder.rref(nonZeroKernel),...
                numKernElem,...
                coder.rref(conn),...
                nconnDims,...
                coder.rref(connDims),...
                coder.rref(start),...
                numStartElem,...
                sameSize,...
                convMode);
        end
        
        
    end
    
    
end
