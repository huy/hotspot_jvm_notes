export LD_LIBRARY_PATH=`pwd`
java  -XX:+UnlockDiagnosticVMOptions \
-XX:+PrintAssembly \
-XX:PrintAssemblyOptions="hsdis-print-bytes" \
-server -cp . TestVolatile

