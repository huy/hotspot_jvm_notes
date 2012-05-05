export LD_LIBRARY_PATH=`pwd`
java  -XX:+UnlockDiagnosticVMOptions \
-XX:+PrintAssembly \
-XX:PrintAssemblyOptions="hsdis-print-bytes" \
-XX:+PrintCompilation \
-server -cp . TestVolatile

