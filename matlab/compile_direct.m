function compile_direct(flags)

common_scs = '../src/linAlg.c ../src/cones.c ../src/cs.c ../src/util.c ../src/scs.c scs_mex.c';
d = '-fPIC -DDLONG';
if (~isempty (strfind (computer, '64')))
    arr = '-largeArrayDims';
else
    arr = '';
end
if ( isunix && ~ismac ) 
    link = '-lm -lrt';
else
    link = '-lm';
end

cmd = sprintf ('mex -O %s CFLAGS="-O3 -DMATLAB_MEX_FILE %s %s" -I"../include" %s', arr, d, flags.LCFLAG, flags.INCS) ;
amd_files = {'amd_order', 'amd_dump', 'amd_postorder', 'amd_post_tree', ...
    'amd_aat', 'amd_2', 'amd_1', 'amd_defaults', 'amd_control', ...
    'amd_info', 'amd_valid', 'amd_global', 'amd_preprocess' } ;
for i = 1 : length (amd_files)
    cmd = sprintf ('%s ../linsys/direct/external/%s.c', cmd, amd_files {i}) ;
end
cmd = sprintf ('%s ../linsys/direct/external/ldl.c %s ../linsys/direct/private.c %s %s %s -output scs_direct', cmd, common_scs, link, flags.LOCS, flags.BLASLIB) ;
eval(cmd);
