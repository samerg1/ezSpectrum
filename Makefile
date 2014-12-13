#Machine-dependent variables
CXX = g++

CXXFLAGSDEP = -DUNDERSCORE 
CXXFLAGS = $(CXXFLAGSDEP) -O2 

CODE = ezSpectrum

LMATH = -llapack -lblas
LXML = -lexpat
LIBS = $(LMATH) $(LXML)

LDFLAGS = -L/usr/lib64 $(LIBS) -lm -lgfortran

CXX_MOLECULAR_PROP = molecular_prop/molstate.C molecular_prop/atom.C molecular_prop/normalmode.C molecular_prop/simple_xml_parser.C molecular_prop/vibronic_state.C  molecular_prop/vector3d.C molecular_prop/spectrum.C  molecular_prop/spectralpoint.C
CXX_MATRIX_MATH = matrix_math/blas_calls.C  matrix_math/kmatrix.C  matrix_math/tmp_buffer.C  
CXX_BASIC_METHODS = basic_methods/genutil.C  basic_methods/mathutil.C 
CXX_COMMON = $(CXX_MOLECULAR_PROP) $(CXX_MATRIX_MATH) $(CXX_BASIC_METHODS)

CXX_HARMONIC_PES = harmonic_pes/franck_condon.C  harmonic_pes/harmonic_pes_main.C  harmonic_pes/parallel_approximation.C harmonic_pes/vibrational_indexing.C  harmonic_pes/dushinsky.C

CXX_SRC = main.C $(CXX_COMMON) $(CXX_HARMONIC_PES)

CXX_WNO_DEPRECATED = -Wno-deprecated

INCLUDES_COMMON = -I molecular_prop/ -I matrix_math/ -I basic_methods/ 
INCLUDES_HARMONIC_PES = -I harmonic_pes/

INCLUDES = $(INCLUDES_COMMON) $(INCLUDES_HARMONIC_PES)  

CXXBINOBJ = $(CXX_SRC:%.C=%.o)

#debug: to compile add: -g "after all (CXX)" :) ; gdb ezSpectrum; r <filename>; 
#profile: to compile add: -pg "after all (CXX)" :) ; run ; than "gprof ezSpectrum gmon.out > out.prof"

$(CODE): $(CXXBINOBJ)
	$(CXX)  -static $^ $(LDFLAGS) $(INCLUDES) -o $(CODE)

%.o: %.C
	$(CXX)  $(CXX_WNO_DEPRECATED) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	/bin/rm -f $(CODE) *.o $(CXXBINOBJ)	


