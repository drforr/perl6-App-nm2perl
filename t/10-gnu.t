use v6.c;
use Test;
use App::nm2perl6::gnu;

#`{
use NativeCall;

class Foo is repr<CPPStruct> {
    has Pointer $.vtable;

    method new()          is nativeconv('thisgnu')               is native("./13-cpp-mangling") { * }
    method TakeAVoid()                             returns int32 is native("./13-cpp-mangling") { * }
    method TakeABool(Bool)                         returns int32 is native("./13-cpp-mangling") { * }
    method TakeAChar(int8)                         returns int32 is native("./13-cpp-mangling") { * }
    method TakeAShort(int16)                       returns int32 is native("./13-cpp-mangling") { * }
    method TakeAnInt(int32)                        returns int32 is native("./13-cpp-mangling") { * }
    method TakeALong(long)                         returns int32 is native("./13-cpp-mangling") { * }
    method TakeALongLong(longlong)                 returns int32 is native("./13-cpp-mangling") { * }
    method TakeAFloat(num32)                       returns int32 is native("./13-cpp-mangling") { * }
    method TakeADouble(num64)                      returns int32 is native("./13-cpp-mangling") { * }
    method TakeAString(Str)                        returns int32 is native("./13-cpp-mangling") { * }
    method TakeAnArray(CArray[int32])              returns int32 is native("./13-cpp-mangling") { * }
    method TakeAPointer(Pointer)                   returns int32 is native("./13-cpp-mangling") { * }
    method TakeABoolPointer(Pointer[Bool])         returns int32 is native("./13-cpp-mangling") { * }
    method TakeACharPointer(Pointer[int8])         returns int32 is native("./13-cpp-mangling") { * }
    method TakeAShortPointer(Pointer[int16])       returns int32 is native("./13-cpp-mangling") { * }
    method TakeAnIntPointer(Pointer[int32])        returns int32 is native("./13-cpp-mangling") { * }
    method TakeALongPointer(Pointer[long])         returns int32 is native("./13-cpp-mangling") { * }
    method TakeALongLongPointer(Pointer[longlong]) returns int32 is native("./13-cpp-mangling") { * }
    method TakeAFloatPointer(Pointer[num32])       returns int32 is native("./13-cpp-mangling") { * }
    method TakeADoublePointer(Pointer[num64])      returns int32 is native("./13-cpp-mangling") { * }
    method TakeAUInt(uint32)                       returns int32 is native("./13-cpp-mangling") { * }
    method TakeAUShort(uint16)                     returns int32 is native("./13-cpp-mangling") { * }
    method TakeAUChar(uint8)                       returns int32 is native("./13-cpp-mangling") { * }
    method TakeAInt64(int64)                       returns int32 is native("./13-cpp-mangling") { * }
    method TakeAULongLong(ulonglong)               returns int32 is native("./13-cpp-mangling") { * }
    method TakeAUInt64(uint64)                     returns int32 is native("./13-cpp-mangling") { * }
}
}

{
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
	0000000000202020 B __bss_start
	0000000000202020 b completed.6972
			 w __cxa_finalize@@GLIBC_2.2.5
	0000000000000fc0 t deregister_tm_clones
	0000000000001050 t __do_global_dtors_aux
	0000000000201d10 t __do_global_dtors_aux_fini_array_entry
	0000000000202018 d __dso_handle
	0000000000201e10 d _DYNAMIC
	0000000000202020 D _edata
	0000000000202028 B _end
	0000000000001300 T _fini
	0000000000001090 t frame_dummy
	0000000000201d08 t __frame_dummy_init_array_entry
	00000000000017e8 r __FRAME_END__
	0000000000202000 d _GLOBAL_OFFSET_TABLE_
			 w __gmon_start__
	0000000000001310 r __GNU_EH_FRAME_HDR
	0000000000000f80 T _init
			 w _ITM_deregisterTMCloneTable
			 w _ITM_registerTMCloneTable
	0000000000201d18 d __JCR_END__
	0000000000201d18 d __JCR_LIST__
			 w _Jv_RegisterClasses
	0000000000001000 t register_tm_clones
	0000000000202020 d __TMC_END__
	000000000000110c T _ZN3Foo9TakeABoolEb
	000000000000110c T _ZN3Foo9TakeABoolEc
	00000000000010c0 T _ZN3FooC1Ev
	00000000000010c0 T _ZN3FooC2Ev
	00000000000010de T _ZN3FooD1Ev
	00000000000010de T _ZN3FooD2Ev
	0000000000201e00 V _ZTI3Foo
	0000000000001309 V _ZTS3Foo
	0000000000201d20 V _ZTV3Foo
			 U _ZTVN10__cxxabiv117__class_type_infoE@@CXXABI_1.3
	_END_

	is $nm.to-perl6, Q:to[_END_], q{from rakudo/13-cpp-mangling};
	use NativeCall;

	class Foo is repr( 'CPPStruct' ) {
		has Pointer $.vtable;
		multi method TakeABool( Bool ) is native( 'library' ) { * }
		multi method TakeABool( int8 ) is native( 'library' ) { * }
		method new(  ) is nativeconv( 'thisgnu' ) is native( 'library' ) { * }
	}
	_END_
};

{
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
	0000000000202020 B __bss_start
	0000000000202020 b completed.6972
			 w __cxa_finalize@@GLIBC_2.2.5
	0000000000000fc0 t deregister_tm_clones
	0000000000001050 t __do_global_dtors_aux
	0000000000201d10 t __do_global_dtors_aux_fini_array_entry
	0000000000202018 d __dso_handle
	0000000000201e10 d _DYNAMIC
	0000000000202020 D _edata
	0000000000202028 B _end
	0000000000001300 T _fini
	0000000000001090 t frame_dummy
	0000000000201d08 t __frame_dummy_init_array_entry
	00000000000017e8 r __FRAME_END__
	0000000000202000 d _GLOBAL_OFFSET_TABLE_
			 w __gmon_start__
	0000000000001310 r __GNU_EH_FRAME_HDR
	0000000000000f80 T _init
			 w _ITM_deregisterTMCloneTable
			 w _ITM_registerTMCloneTable
	0000000000201d18 d __JCR_END__
	0000000000201d18 d __JCR_LIST__
			 w _Jv_RegisterClasses
	0000000000001000 t register_tm_clones
	0000000000202020 d __TMC_END__
	0000000000001184 T _ZN3Foo10TakeAFloatEf
	00000000000012c4 T _ZN3Foo10TakeAInt64Ex
	0000000000001134 T _ZN3Foo10TakeAShortEs
	00000000000012b0 T _ZN3Foo10TakeAUCharEh
	0000000000001198 T _ZN3Foo11TakeADoubleEd
	00000000000011c0 T _ZN3Foo11TakeAnArrayEPi
	00000000000011ac T _ZN3Foo11TakeAStringEPc
	00000000000012ec T _ZN3Foo11TakeAUInt64Ey
	000000000000129a T _ZN3Foo11TakeAUShortEt
	00000000000011d4 T _ZN3Foo12TakeAPointerEPv
	0000000000001170 T _ZN3Foo13TakeALongLongEx
	00000000000012d8 T _ZN3Foo14TakeAULongLongEy
	00000000000011e8 T _ZN3Foo16TakeABoolPointerEPb
	00000000000011fc T _ZN3Foo16TakeACharPointerEPc
	0000000000001238 T _ZN3Foo16TakeALongPointerEPl
	0000000000001224 T _ZN3Foo16TakeAnIntPointerEPi
	0000000000001260 T _ZN3Foo17TakeAFloatPointerEPf
	0000000000001210 T _ZN3Foo17TakeAShortPointerEPs
	0000000000001274 T _ZN3Foo18TakeADoublePointerEPd
	000000000000124c T _ZN3Foo20TakeALongLongPointerEPx
	000000000000110c T _ZN3Foo9TakeABoolEb
	0000000000001120 T _ZN3Foo9TakeACharEc
	000000000000115c T _ZN3Foo9TakeALongEl
	000000000000114a T _ZN3Foo9TakeAnIntEi
	0000000000001288 T _ZN3Foo9TakeAUIntEj
	00000000000010fc T _ZN3Foo9TakeAVoidEv
	00000000000010c0 T _ZN3FooC1Ev
	00000000000010c0 T _ZN3FooC2Ev
	00000000000010de T _ZN3FooD1Ev
	00000000000010de T _ZN3FooD2Ev
	0000000000201e00 V _ZTI3Foo
	0000000000001309 V _ZTS3Foo
	0000000000201d20 V _ZTV3Foo
			 U _ZTVN10__cxxabiv117__class_type_infoE@@CXXABI_1.3
	_END_

	is $nm.to-perl6, Q:to[_END_], q{from rakudo/13-cpp-mangling};
	use NativeCall;

	class Foo is repr( 'CPPStruct' ) {
		has Pointer $.vtable;
		method TakeABool( Bool ) is native( 'library' ) { * }
		method TakeABoolPointer( Pointer[ Bool ] ) is native( 'library' ) { * }
		method TakeAChar( int8 ) is native( 'library' ) { * }
		method TakeACharPointer( Str ) is native( 'library' ) { * }
		method TakeADouble( num64 ) is native( 'library' ) { * }
		method TakeADoublePointer( Pointer[ num64 ] ) is native( 'library' ) { * }
		method TakeAFloat( num32 ) is native( 'library' ) { * }
		method TakeAFloatPointer( Pointer[ num32 ] ) is native( 'library' ) { * }
		method TakeAInt64( longlong ) is native( 'library' ) { * }
		method TakeALong( long ) is native( 'library' ) { * }
		method TakeALongLong( longlong ) is native( 'library' ) { * }
		method TakeALongLongPointer( Pointer[ longlong ] ) is native( 'library' ) { * }
		method TakeALongPointer( Pointer[ long ] ) is native( 'library' ) { * }
		method TakeAPointer( Pointer ) is native( 'library' ) { * }
		method TakeAShort( int16 ) is native( 'library' ) { * }
		method TakeAShortPointer( Pointer[ int16 ] ) is native( 'library' ) { * }
		method TakeAString( Str ) is native( 'library' ) { * }
		method TakeAUChar( uint8 ) is native( 'library' ) { * }
		method TakeAUInt( uint32 ) is native( 'library' ) { * }
		method TakeAUInt64( ulonglong ) is native( 'library' ) { * }
		method TakeAULongLong( ulonglong ) is native( 'library' ) { * }
		method TakeAUShort( uint16 ) is native( 'library' ) { * }
		method TakeAVoid(  ) is native( 'library' ) { * }
		method TakeAnArray( Pointer[ int32 ] ) is native( 'library' ) { * }
		method TakeAnInt( int32 ) is native( 'library' ) { * }
		method TakeAnIntPointer( Pointer[ int32 ] ) is native( 'library' ) { * }
		method new(  ) is nativeconv( 'thisgnu' ) is native( 'library' ) { * }
	}
	_END_
};

#`{ for this sample:

class Foo {
public:
	Foo();
	~Foo();
	virtual int TakeAVoid(void);
	virtual int TakeABool(bool i);
	virtual int TakeAChar(char i);
	virtual int TakeAShort(short i);
	virtual int TakeAnInt(int i);
	virtual int TakeALong(long i);
	virtual int TakeALongLong(long long i);
	virtual int TakeAFloat(float i);
	virtual int TakeADouble(double i);
	virtual int TakeAString(char *i);
	virtual int TakeAnArray(int i[]);
	virtual int TakeAPointer(void *i);
	virtual int TakeABoolPointer(bool *i);
	virtual int TakeACharPointer(char *i);
	virtual int TakeAShortPointer(short *i);
	virtual int TakeAnIntPointer(int *i);
	virtual int TakeALongPointer(long *i);
	virtual int TakeALongLongPointer(long long *i);
	virtual int TakeAFloatPointer(float *i);
	virtual int TakeADoublePointer(double *i);
	virtual int TakeAUInt(unsigned int i);
	virtual int TakeAUShort(unsigned short i);
	virtual int TakeAUChar(unsigned char i);
	virtual int TakeAInt64(long long i);
	virtual int TakeAULongLong(unsigned long long i);
	virtual int TakeAUInt64(unsigned long long i);
};

Foo::Foo()  { };
Foo::~Foo() { };

int Foo::TakeAVoid(void)                    { return  0; }
int Foo::TakeABool(bool i)                  { return  1; }
int Foo::TakeAChar(char i)                  { return  2; }
int Foo::TakeAShort(short i)                { return  3; }
int Foo::TakeAnInt(int i)                   { return  4; }
int Foo::TakeALong(long i)                  { return  5; }
int Foo::TakeALongLong(long long i)         { return  6; }
int Foo::TakeAFloat(float i)                { return  7; }
int Foo::TakeADouble(double i)              { return  8; }
int Foo::TakeAString(char *i)               { return  9; }
int Foo::TakeAnArray(int i[])               { return 10; }
int Foo::TakeAPointer(void *i)              { return 11; }
int Foo::TakeABoolPointer(bool *i)          { return 12; }
int Foo::TakeACharPointer(char *i)          { return 13; }
int Foo::TakeAShortPointer(short *i)        { return 14; }
int Foo::TakeAnIntPointer(int *i)           { return 15; }
int Foo::TakeALongPointer(long *i)          { return 16; }
int Foo::TakeALongLongPointer(long long *i) { return 17; }
int Foo::TakeAFloatPointer(float *i)        { return 18; }
int Foo::TakeADoublePointer(double *i)      { return 19; }
int Foo::TakeAUInt(unsigned int i)          { return 20; }
int Foo::TakeAUShort(unsigned short i)      { return 21; }
int Foo::TakeAUChar(unsigned char i)        { return 22; }
int Foo::TakeAInt64(long long i)            { return 23; }
int Foo::TakeAULongLong(unsigned long long i) { return 24; }
int Foo::TakeAUInt64(unsigned long long i)    { return 25; }
}

{
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
	000000000020e1f8 B __bss_start
	000000000020e1f8 b completed.6972
			 U __cxa_allocate_exception@@CXXABI_1.3
			 U __cxa_atexit@@GLIBC_2.2.5
			 w __cxa_finalize@@GLIBC_2.2.5
			 U __cxa_free_exception@@CXXABI_1.3
			 U __cxa_pure_virtual@@CXXABI_1.3
			 U __cxa_throw@@CXXABI_1.3
	0000000000005a60 t deregister_tm_clones
	0000000000005af0 t __do_global_dtors_aux
	000000000020d560 t __do_global_dtors_aux_fini_array_entry
	000000000020e1e8 d __dso_handle
	000000000020e1f0 d DW.ref.__gxx_personality_v0
	000000000020dcd0 d _DYNAMIC
	000000000020e1f8 D _edata
	000000000020e200 B _end
			 U exit@@GLIBC_2.2.5
	000000000000ae80 T _fini
			 U floor@@GLIBC_2.2.5
	0000000000005b30 t frame_dummy
	000000000020d548 t __frame_dummy_init_array_entry
	000000000000cf00 r __FRAME_END__
			 U free@@GLIBC_2.2.5
			 U gettimeofday@@GLIBC_2.2.5
	000000000020e000 d _GLOBAL_OFFSET_TABLE_
	0000000000005a00 t _GLOBAL__sub_I_options.cpp
	0000000000005a30 t _GLOBAL__sub_I_script.cpp
			 w __gmon_start__
	000000000000bc88 r __GNU_EH_FRAME_HDR
			 U __gxx_personality_v0@@CXXABI_1.3
	00000000000055d0 T _init
			 w _ITM_deregisterTMCloneTable
			 w _ITM_registerTMCloneTable
	000000000020d568 d __JCR_END__
	000000000020d568 d __JCR_LIST__
			 w _Jv_RegisterClasses
			 U malloc@@GLIBC_2.2.5
	0000000000005aa0 t register_tm_clones
			 U strcmp@@GLIBC_2.2.5
			 U strcpy@@GLIBC_2.2.5
			 U strlen@@GLIBC_2.2.5
			 U strtod@@GLIBC_2.2.5
			 U strtol@@GLIBC_2.2.5
			 U sysconf@@GLIBC_2.2.5
	000000000020e1f8 d __TMC_END__
			 U _Unwind_Resume@@GCC_3.0
			 U _ZdlPv@@GLIBCXX_3.4
	0000000000008a30 T _ZN6Gecode11BaseOptions3addERNS_6Driver10BaseOptionE
	0000000000008ac0 T _ZN6Gecode11BaseOptions5parseERiPPc
	0000000000008a60 T _ZN6Gecode11BaseOptionsC2EPKc
	0000000000007bd0 T _ZN6Gecode11BaseOptionsD0Ev
	0000000000007bb0 T _ZN6Gecode11BaseOptionsD1Ev
	0000000000007bb0 T _ZN6Gecode11BaseOptionsD2Ev
	0000000000009a70 T _ZN6Gecode11SizeOptions5parseERiPPc
	0000000000009a40 T _ZN6Gecode11SizeOptionsC2EPKc
	000000000000a6d0 W _ZN6Gecode11SizeOptionsD0Ev
	000000000000a190 W _ZN6Gecode11SizeOptionsD1Ev
	000000000000a190 W _ZN6Gecode11SizeOptionsD2Ev
	0000000000009b70 W _ZN6Gecode12SharedHandle6ObjectD0Ev
	0000000000009b60 W _ZN6Gecode12SharedHandle6ObjectD1Ev
	0000000000009b60 W _ZN6Gecode12SharedHandle6ObjectD2Ev
	0000000000009b10 T _ZN6Gecode15InstanceOptions5parseERiPPc
	0000000000009ab0 T _ZN6Gecode15InstanceOptionsC2EPKc
	0000000000008870 T _ZN6Gecode15InstanceOptionsD0Ev
	00000000000085c0 T _ZN6Gecode15InstanceOptionsD1Ev
	00000000000085c0 T _ZN6Gecode15InstanceOptionsD2Ev
			 U _ZN6Gecode15MemoryExhaustedC1Ev
	000000000000a970 W _ZN6Gecode15MemoryExhaustedD0Ev
	0000000000009d40 W _ZN6Gecode15MemoryExhaustedD1Ev
	0000000000009d40 W _ZN6Gecode15MemoryExhaustedD2Ev
			 U _ZN6Gecode20OperatingSystemErrorC1EPKc
	000000000000ae60 W _ZN6Gecode20OperatingSystemErrorD0Ev
	000000000000ae40 W _ZN6Gecode20OperatingSystemErrorD1Ev
	000000000000ae40 W _ZN6Gecode20OperatingSystemErrorD2Ev
	0000000000009d00 t _ZN6Gecode3DFA4DFAID0Ev
	0000000000009cd0 t _ZN6Gecode3DFA4DFAID1Ev
	0000000000009cd0 t _ZN6Gecode3DFA4DFAID2Ev
	0000000000009c50 W _ZN6Gecode5Actor7disposeERNS_5SpaceE
	0000000000009c70 W _ZN6Gecode6ChoiceD0Ev
	0000000000009c60 W _ZN6Gecode6ChoiceD1Ev
	0000000000009c60 W _ZN6Gecode6ChoiceD2Ev
	0000000000008470 T _ZN6Gecode6Driver10BaseOptionC1EPKcS3_
	0000000000008470 T _ZN6Gecode6Driver10BaseOptionC2EPKcS3_
	0000000000008890 T _ZN6Gecode6Driver10BaseOptionD0Ev
	00000000000084c0 T _ZN6Gecode6Driver10BaseOptionD1Ev
	00000000000084c0 T _ZN6Gecode6Driver10BaseOptionD2Ev
	0000000000005b60 T _ZN6Gecode6Driver10BoolOption5parseEiPPc
	0000000000009dd0 W _ZN6Gecode6Driver10BoolOptionD0Ev
	0000000000009db0 W _ZN6Gecode6Driver10BoolOptionD1Ev
	0000000000009db0 W _ZN6Gecode6Driver10BoolOptionD2Ev
	00000000000080b0 T _ZN6Gecode6Driver11TraceOption5parseEiPPc
	00000000000089f0 T _ZN6Gecode6Driver11TraceOptionC2Ei
	0000000000009d90 W _ZN6Gecode6Driver11TraceOptionD0Ev
	0000000000009d70 W _ZN6Gecode6Driver11TraceOptionD1Ev
	0000000000009d70 W _ZN6Gecode6Driver11TraceOptionD2Ev
	0000000000007e70 T _ZN6Gecode6Driver12DoubleOption5parseEiPPc
	0000000000009e50 W _ZN6Gecode6Driver12DoubleOptionD0Ev
	0000000000009e30 W _ZN6Gecode6Driver12DoubleOptionD1Ev
	0000000000009e30 W _ZN6Gecode6Driver12DoubleOptionD2Ev
	0000000000008930 T _ZN6Gecode6Driver12StringOption3addEiPKcS3_
	0000000000007ca0 T _ZN6Gecode6Driver12StringOption5parseEiPPc
	00000000000085a0 T _ZN6Gecode6Driver12StringOptionD0Ev
	0000000000008540 T _ZN6Gecode6Driver12StringOptionD1Ev
	0000000000008540 T _ZN6Gecode6Driver12StringOptionD2Ev
	0000000000008440 T _ZN6Gecode6Driver17StringValueOption5parseEiPPc
	00000000000088b0 T _ZN6Gecode6Driver17StringValueOptionC1EPKcS3_S3_
	00000000000088b0 T _ZN6Gecode6Driver17StringValueOptionC2EPKcS3_S3_
	0000000000008520 T _ZN6Gecode6Driver17StringValueOptionD0Ev
	00000000000084f0 T _ZN6Gecode6Driver17StringValueOptionD1Ev
	00000000000084f0 T _ZN6Gecode6Driver17StringValueOptionD2Ev
	0000000000007e30 T _ZN6Gecode6Driver17UnsignedIntOption5parseEiPPc
	0000000000009e10 W _ZN6Gecode6Driver17UnsignedIntOptionD0Ev
	0000000000009df0 W _ZN6Gecode6Driver17UnsignedIntOptionD1Ev
	0000000000009df0 W _ZN6Gecode6Driver17UnsignedIntOptionD2Ev
	000000000000a990 T _ZN6Gecode6Driver4stopERNS_7Support5TimerERSo
	0000000000007df0 T _ZN6Gecode6Driver9IntOption5parseEiPPc
	000000000000a170 W _ZN6Gecode6Driver9IntOptionD0Ev
	000000000000a150 W _ZN6Gecode6Driver9IntOptionD1Ev
	000000000000a150 W _ZN6Gecode6Driver9IntOptionD2Ev
	0000000000007ea0 T _ZN6Gecode6Driver9IplOption5parseEiPPc
	00000000000089b0 T _ZN6Gecode6Driver9IplOptionC1ENS_12IntPropLevelE
	00000000000089b0 T _ZN6Gecode6Driver9IplOptionC2ENS_12IntPropLevelE
	000000000000a130 W _ZN6Gecode6Driver9IplOptionD0Ev
	0000000000009e70 W _ZN6Gecode6Driver9IplOptionD1Ev
	0000000000009e70 W _ZN6Gecode6Driver9IplOptionD2Ev
	0000000000009be0 t _ZN6Gecode6Kernel15SharedSpaceData4DataD0Ev
	0000000000009b80 t _ZN6Gecode6Kernel15SharedSpaceData4DataD1Ev
	0000000000009b80 t _ZN6Gecode6Kernel15SharedSpaceData4DataD2Ev
			 U _ZN6Gecode7Archive6resizeEi
	0000000000008bc0 T _ZN6Gecode7OptionsC2EPKc
	000000000000a430 W _ZN6Gecode7OptionsD0Ev
	0000000000009e90 W _ZN6Gecode7OptionsD1Ev
	0000000000009e90 W _ZN6Gecode7OptionsD2Ev
	0000000000009d60 W _ZN6Gecode9PosChoiceD0Ev
	0000000000009d30 W _ZN6Gecode9PosChoiceD1Ev
	0000000000009d30 W _ZN6Gecode9PosChoiceD2Ev
			 U _ZNK6Gecode6Choice7archiveERNS_7ArchiveE
	0000000000007bf0 T _ZNK6Gecode6Driver10BaseOption8argumentEiPPc
	0000000000009c80 W _ZNK6Gecode9PosChoice7archiveERNS_7ArchiveE
			 U _ZNKSt5ctypeIcE13_M_widen_initEv@@GLIBCXX_3.4.11
	0000000000009b50 W _ZNKSt5ctypeIcE8do_widenEc
			 U _ZNSo3putEc@@GLIBCXX_3.4
			 U _ZNSo5flushEv@@GLIBCXX_3.4
			 U _ZNSo9_M_insertIdEERSoT_@@GLIBCXX_3.4.9
			 U _ZNSo9_M_insertImEERSoT_@@GLIBCXX_3.4.9
			 U _ZNSolsEi@@GLIBCXX_3.4
			 U _ZNSt8ios_base4InitC1Ev@@GLIBCXX_3.4
			 U _ZNSt8ios_base4InitD1Ev@@GLIBCXX_3.4
			 U _ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@@GLIBCXX_3.4
			 U _ZNSt9exceptionD2Ev@@GLIBCXX_3.4
			 U _Znwm@@GLIBCXX_3.4
			 U _ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@@GLIBCXX_3.4.9
			 U _ZSt16__throw_bad_castv@@GLIBCXX_3.4
			 U _ZSt4cerr@@GLIBCXX_3.4
			 U _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@@GLIBCXX_3.4
	000000000020e1f9 b _ZStL8__ioinit
	000000000020e1fb b _ZStL8__ioinit
	00000000000059b0 t _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.constprop.12
			 U _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@@GLIBCXX_3.4
	_END_

	is-deeply $nm.classes, { }, q{Unparseable names};
};

{
	# _ZT <[ V T I S ]> are virtual tables
	# _ZN...C1Ev is completely parsed, but the U indicates it's undefined.
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
			 U _ZN6Gecode15MemoryExhaustedC1Ev
			 U _ZdlPv@@GLIBCXX_3.4
	000000000020d5c0 d _ZTIN6Gecode10TracerBaseE
	000000000020d800 V _ZTIN6Gecode11BaseOptionsE
	000000000020d828 V _ZTIN6Gecode11SizeOptionsE
	000000000020d6a0 d _ZTIN6Gecode12SearchTracerE
	000000000020d600 V _ZTIN6Gecode12SharedHandle6ObjectE
	000000000020d5d8 V _ZTIN6Gecode13HeapAllocatedE
	000000000020d710 d _ZTIN6Gecode13NonLinIntExprE
	000000000020d840 V _ZTIN6Gecode15InstanceOptionsE
	000000000020d5e8 V _ZTIN6Gecode15MemoryExhaustedE
	000000000020d720 d _ZTIN6Gecode15NonLinFloatExprE
	000000000020dcb8 V _ZTIN6Gecode20OperatingSystemErrorE
	000000000020d6f8 d _ZTIN6Gecode3DFA4DFAIE
	000000000020d630 V _ZTIN6Gecode5ActorE
	000000000020d658 V _ZTIN6Gecode6ChoiceE
	000000000020d730 V _ZTIN6Gecode6Driver10BaseOptionE
	000000000020d7b8 V _ZTIN6Gecode6Driver10BoolOptionE
	000000000020d7e8 V _ZTIN6Gecode6Driver11TraceOptionE
	000000000020d7a0 V _ZTIN6Gecode6Driver12DoubleOptionE
	000000000020d758 V _ZTIN6Gecode6Driver12StringOptionE
	000000000020d740 V _ZTIN6Gecode6Driver17StringValueOptionE
	000000000020d788 V _ZTIN6Gecode6Driver17UnsignedIntOptionE
	000000000020d770 V _ZTIN6Gecode6Driver9IntOptionE
	000000000020d7d0 V _ZTIN6Gecode6Driver9IplOptionE
	000000000020d618 d _ZTIN6Gecode6Kernel15SharedSpaceData4DataE
	000000000020d6c8 V _ZTIN6Gecode6Search4StopE
	000000000020d6b0 V _ZTIN6Gecode6Search6CutoffE
	000000000020d6e0 V _ZTIN6Gecode6Search7BuilderE
	000000000020d688 d _ZTIN6Gecode6TracerE
	000000000020d810 V _ZTIN6Gecode7OptionsE
	000000000020d5b0 d _ZTIN6Gecode9ActorLinkE
			 U _ZTIN6Gecode9ExceptionE
	000000000020d670 V _ZTIN6Gecode9PosChoiceE
	000000000000b840 r _ZTSN6Gecode10TracerBaseE
	000000000000bb90 V _ZTSN6Gecode11BaseOptionsE
	000000000000bbd0 V _ZTSN6Gecode11SizeOptionsE
	000000000000b960 r _ZTSN6Gecode12SearchTracerE
	000000000000b8a0 V _ZTSN6Gecode12SharedHandle6ObjectE
	000000000000b860 V _ZTSN6Gecode13HeapAllocatedE
	000000000000ba00 r _ZTSN6Gecode13NonLinIntExprE
	000000000000bbf0 V _ZTSN6Gecode15InstanceOptionsE
	000000000000b880 V _ZTSN6Gecode15MemoryExhaustedE
	000000000000ba20 r _ZTSN6Gecode15NonLinFloatExprE
	000000000000bc60 V _ZTSN6Gecode20OperatingSystemErrorE
	000000000000b9e0 r _ZTSN6Gecode3DFA4DFAIE
	000000000000b8f0 V _ZTSN6Gecode5ActorE
	000000000000b900 V _ZTSN6Gecode6ChoiceE
	000000000000ba40 V _ZTSN6Gecode6Driver10BaseOptionE
	000000000000bb30 V _ZTSN6Gecode6Driver10BoolOptionE
	000000000000bb70 V _ZTSN6Gecode6Driver11TraceOptionE
	000000000000bb10 V _ZTSN6Gecode6Driver12DoubleOptionE
	000000000000ba90 V _ZTSN6Gecode6Driver12StringOptionE
	000000000000ba60 V _ZTSN6Gecode6Driver17StringValueOptionE
	000000000000bae0 V _ZTSN6Gecode6Driver17UnsignedIntOptionE
	000000000000bab0 V _ZTSN6Gecode6Driver9IntOptionE
	000000000000bb50 V _ZTSN6Gecode6Driver9IplOptionE
	000000000000b8c0 r _ZTSN6Gecode6Kernel15SharedSpaceData4DataE
	000000000000b9a0 V _ZTSN6Gecode6Search4StopE
	000000000000b980 V _ZTSN6Gecode6Search6CutoffE
	000000000000b9c0 V _ZTSN6Gecode6Search7BuilderE
	000000000000b940 r _ZTSN6Gecode6TracerE
	000000000000bbb0 V _ZTSN6Gecode7OptionsE
	000000000000b820 r _ZTSN6Gecode9ActorLinkE
	000000000000b920 V _ZTSN6Gecode9PosChoiceE
			 U _ZTVN10__cxxabiv117__class_type_infoE@@CXXABI_1.3
			 U _ZTVN10__cxxabiv120__si_class_type_infoE@@CXXABI_1.3
			 U _ZTVN10__cxxabiv121__vmi_class_type_infoE@@CXXABI_1.3
	000000000020dc40 V _ZTVN6Gecode11BaseOptionsE
	000000000020dc68 V _ZTVN6Gecode11SizeOptionsE
	000000000020d930 d _ZTVN6Gecode12SearchTracerE
	000000000020d858 V _ZTVN6Gecode12SharedHandle6ObjectE
	000000000020d9f8 d _ZTVN6Gecode13NonLinIntExprE
	000000000020dc90 V _ZTVN6Gecode15InstanceOptionsE
	000000000020da30 d _ZTVN6Gecode15NonLinFloatExprE
	000000000020d590 d _ZTVN6Gecode3DFA4DFAIE
	000000000020d878 V _ZTVN6Gecode5ActorE
	000000000020d8a8 V _ZTVN6Gecode6ChoiceE
	000000000020da90 V _ZTVN6Gecode6Driver10BaseOptionE
	000000000020dbb0 V _ZTVN6Gecode6Driver10BoolOptionE
	000000000020dc10 V _ZTVN6Gecode6Driver11TraceOptionE
	000000000020db80 V _ZTVN6Gecode6Driver12DoubleOptionE
	000000000020daf0 V _ZTVN6Gecode6Driver12StringOptionE
	000000000020dac0 V _ZTVN6Gecode6Driver17StringValueOptionE
	000000000020db50 V _ZTVN6Gecode6Driver17UnsignedIntOptionE
	000000000020db20 V _ZTVN6Gecode6Driver9IntOptionE
	000000000020dbe0 V _ZTVN6Gecode6Driver9IplOptionE
	000000000020d570 d _ZTVN6Gecode6Kernel15SharedSpaceData4DataE
	000000000020d9a8 V _ZTVN6Gecode6Search4StopE
	000000000020d978 V _ZTVN6Gecode6Search6CutoffE
	000000000020d9d0 V _ZTVN6Gecode6Search7BuilderE
	000000000020d8f8 d _ZTVN6Gecode6TracerE
	000000000020da68 V _ZTVN6Gecode7OptionsE
			 U _ZTVN6Gecode9ExceptionE
	000000000020d8d0 V _ZTVN6Gecode9PosChoiceE
	_END_
	is-deeply $nm.classes, { }, q{Currently-unparsed terms};
};

{
	# _ZT <[ V T I S ]> are virtual tables
	# _ZN...C1Ev is completely parsed, but the U indicates it's undefined.
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
	0000000000008a60 T _ZN6Gecode11BaseOptionsC2EPKc
	0000000000007bd0 T _ZN6Gecode11BaseOptionsD0Ev
	0000000000007bb0 T _ZN6Gecode11BaseOptionsD1Ev
	0000000000007bb0 T _ZN6Gecode11BaseOptionsD2Ev
	0000000000009a40 T _ZN6Gecode11SizeOptionsC2EPKc
	000000000000a6d0 W _ZN6Gecode11SizeOptionsD0Ev
	000000000000a190 W _ZN6Gecode11SizeOptionsD1Ev
	000000000000a190 W _ZN6Gecode11SizeOptionsD2Ev
	0000000000009b70 W _ZN6Gecode12SharedHandle6ObjectD0Ev
	0000000000009b60 W _ZN6Gecode12SharedHandle6ObjectD1Ev
	0000000000009b60 W _ZN6Gecode12SharedHandle6ObjectD2Ev
	0000000000009ab0 T _ZN6Gecode15InstanceOptionsC2EPKc
	0000000000008870 T _ZN6Gecode15InstanceOptionsD0Ev
	00000000000085c0 T _ZN6Gecode15InstanceOptionsD1Ev
	00000000000085c0 T _ZN6Gecode15InstanceOptionsD2Ev
	000000000000a970 W _ZN6Gecode15MemoryExhaustedD0Ev
	0000000000009d40 W _ZN6Gecode15MemoryExhaustedD1Ev
	0000000000009d40 W _ZN6Gecode15MemoryExhaustedD2Ev
	000000000000ae60 W _ZN6Gecode20OperatingSystemErrorD0Ev
	000000000000ae40 W _ZN6Gecode20OperatingSystemErrorD1Ev
	000000000000ae40 W _ZN6Gecode20OperatingSystemErrorD2Ev
	0000000000009d00 t _ZN6Gecode3DFA4DFAID0Ev
	0000000000009cd0 t _ZN6Gecode3DFA4DFAID1Ev
	0000000000009cd0 t _ZN6Gecode3DFA4DFAID2Ev
	0000000000009c70 W _ZN6Gecode6ChoiceD0Ev
	0000000000009c60 W _ZN6Gecode6ChoiceD1Ev
	0000000000009c60 W _ZN6Gecode6ChoiceD2Ev
	0000000000008470 T _ZN6Gecode6Driver10BaseOptionC2EPKcS3_
	0000000000008890 T _ZN6Gecode6Driver10BaseOptionD0Ev
	00000000000084c0 T _ZN6Gecode6Driver10BaseOptionD1Ev
	00000000000084c0 T _ZN6Gecode6Driver10BaseOptionD2Ev
	0000000000009dd0 W _ZN6Gecode6Driver10BoolOptionD0Ev
	0000000000009db0 W _ZN6Gecode6Driver10BoolOptionD1Ev
	0000000000009db0 W _ZN6Gecode6Driver10BoolOptionD2Ev
	00000000000089f0 T _ZN6Gecode6Driver11TraceOptionC2Ei
	0000000000009d90 W _ZN6Gecode6Driver11TraceOptionD0Ev
	0000000000009d70 W _ZN6Gecode6Driver11TraceOptionD1Ev
	0000000000009d70 W _ZN6Gecode6Driver11TraceOptionD2Ev
	0000000000009e50 W _ZN6Gecode6Driver12DoubleOptionD0Ev
	0000000000009e30 W _ZN6Gecode6Driver12DoubleOptionD1Ev
	0000000000009e30 W _ZN6Gecode6Driver12DoubleOptionD2Ev
	00000000000085a0 T _ZN6Gecode6Driver12StringOptionD0Ev
	0000000000008540 T _ZN6Gecode6Driver12StringOptionD1Ev
	0000000000008540 T _ZN6Gecode6Driver12StringOptionD2Ev
	00000000000088b0 T _ZN6Gecode6Driver17StringValueOptionC1EPKcS3_S3_
	0000000000008520 T _ZN6Gecode6Driver17StringValueOptionD0Ev
	00000000000084f0 T _ZN6Gecode6Driver17StringValueOptionD1Ev
	00000000000084f0 T _ZN6Gecode6Driver17StringValueOptionD2Ev
	0000000000009e10 W _ZN6Gecode6Driver17UnsignedIntOptionD0Ev
	0000000000009df0 W _ZN6Gecode6Driver17UnsignedIntOptionD1Ev
	0000000000009df0 W _ZN6Gecode6Driver17UnsignedIntOptionD2Ev
	000000000000a170 W _ZN6Gecode6Driver9IntOptionD0Ev
	000000000000a150 W _ZN6Gecode6Driver9IntOptionD1Ev
	000000000000a150 W _ZN6Gecode6Driver9IntOptionD2Ev
	00000000000089b0 T _ZN6Gecode6Driver9IplOptionC2ENS_12IntPropLevelE
	000000000000a130 W _ZN6Gecode6Driver9IplOptionD0Ev
	0000000000009e70 W _ZN6Gecode6Driver9IplOptionD1Ev
	0000000000009e70 W _ZN6Gecode6Driver9IplOptionD2Ev
	0000000000009be0 t _ZN6Gecode6Kernel15SharedSpaceData4DataD0Ev
	0000000000009b80 t _ZN6Gecode6Kernel15SharedSpaceData4DataD1Ev
	0000000000009b80 t _ZN6Gecode6Kernel15SharedSpaceData4DataD2Ev
	0000000000008bc0 T _ZN6Gecode7OptionsC2EPKc
	000000000000a430 W _ZN6Gecode7OptionsD0Ev
	0000000000009e90 W _ZN6Gecode7OptionsD1Ev
	0000000000009e90 W _ZN6Gecode7OptionsD2Ev
	0000000000009d60 W _ZN6Gecode9PosChoiceD0Ev
	0000000000009d30 W _ZN6Gecode9PosChoiceD1Ev
	0000000000009d30 W _ZN6Gecode9PosChoiceD2Ev
	_END_

	is-deeply $nm.classes, { }, q{Unused constructors and destructors};
};

{
	my $nm = App::nm2perl6::gnu.new;

	$nm.process-lines: q:to[_END_];
	0000000000008a30 T _ZN6Gecode11BaseOptions3addERNS_6Driver10BaseOptionE
	0000000000006c70 T _ZN6Gecode11BaseOptions4helpEv
	0000000000008a90 T _ZN6Gecode11BaseOptions4nameEPKc
	0000000000008ac0 T _ZN6Gecode11BaseOptions5parseERiPPc
	0000000000008a60 T _ZN6Gecode11BaseOptionsC1EPKc
	0000000000007350 T _ZN6Gecode11SizeOptions4helpEv
	0000000000009a70 T _ZN6Gecode11SizeOptions5parseERiPPc
	0000000000009a40 T _ZN6Gecode11SizeOptionsC1EPKc
	0000000000007470 T _ZN6Gecode15InstanceOptions4helpEv
	0000000000009b10 T _ZN6Gecode15InstanceOptions5parseERiPPc
	0000000000009ae0 T _ZN6Gecode15InstanceOptions8instanceEPKc
	0000000000009ab0 T _ZN6Gecode15InstanceOptionsC1EPKc
	0000000000009c50 W _ZN6Gecode5Actor7disposeERNS_5SpaceE
	0000000000007b90 T _ZN6Gecode6Driver10BaseOption6strdelEPKc
	0000000000007a40 T _ZN6Gecode6Driver10BaseOption6strdupEPKc
	0000000000007ae0 T _ZN6Gecode6Driver10BaseOption7stredupEPKc
	0000000000008470 T _ZN6Gecode6Driver10BaseOptionC1EPKcS3_
	00000000000061b0 T _ZN6Gecode6Driver10BoolOption4helpEv
	0000000000005b60 T _ZN6Gecode6Driver10BoolOption5parseEiPPc
	00000000000075c0 T _ZN6Gecode6Driver11TraceOption4helpEv
	00000000000080b0 T _ZN6Gecode6Driver11TraceOption5parseEiPPc
	00000000000089f0 T _ZN6Gecode6Driver11TraceOptionC1Ei
	000000000020e1fa B _ZN6Gecode6Driver12CombinedStop6sigintE
	0000000000005e20 T _ZN6Gecode6Driver12DoubleOption4helpEv
	0000000000007e70 T _ZN6Gecode6Driver12DoubleOption5parseEiPPc
	0000000000008930 T _ZN6Gecode6Driver12StringOption3addEiPKcS3_
	0000000000006870 T _ZN6Gecode6Driver12StringOption4helpEv
	0000000000007ca0 T _ZN6Gecode6Driver12StringOption5parseEiPPc
	0000000000006390 T _ZN6Gecode6Driver17StringValueOption4helpEv
	0000000000008440 T _ZN6Gecode6Driver17StringValueOption5parseEiPPc
	0000000000008900 T _ZN6Gecode6Driver17StringValueOption5valueEPKc
	00000000000088b0 T _ZN6Gecode6Driver17StringValueOptionC1EPKcS3_S3_
	0000000000005c60 T _ZN6Gecode6Driver17UnsignedIntOption4helpEv
	0000000000007e30 T _ZN6Gecode6Driver17UnsignedIntOption5parseEiPPc
	000000000000ad90 T _ZN6Gecode6Driver2amEPdj
	000000000000add0 T _ZN6Gecode6Driver3devEPdj
	000000000000a990 T _ZN6Gecode6Driver4stopERNS_7Support5TimerERSo
	0000000000005ff0 T _ZN6Gecode6Driver9IntOption4helpEv
	0000000000007df0 T _ZN6Gecode6Driver9IntOption5parseEiPPc
	0000000000006570 T _ZN6Gecode6Driver9IplOption4helpEv
	0000000000007ea0 T _ZN6Gecode6Driver9IplOption5parseEiPPc
	00000000000089b0 T _ZN6Gecode6Driver9IplOptionC1ENS_12IntPropLevelE
	0000000000008bc0 T _ZN6Gecode7OptionsC1EPKc
	0000000000007bf0 T _ZNK6Gecode6Driver10BaseOption8argumentEiPPc
	0000000000009c80 W _ZNK6Gecode9PosChoice7archiveERNS_7ArchiveE
	0000000000009b50 W _ZNKSt5ctypeIcE8do_widenEc
	_END_

#say $nm.classes;
};

done-testing;
