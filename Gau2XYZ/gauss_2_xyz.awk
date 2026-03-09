BEGIN { infinity      = 1000000000;
        COORDRecord   = infinity ;
        EnerOK        = 0 ;
        GeomOK        = 0 ;
        FoundOK       = 0 ;
        natom         = 0 ;
      }


/Coordinates \(Angstroms\)/ {GeomOK = 1; FoundOK = 1; COORDRecord = NR; next} 

NR >= COORDRecord + 3 {
   if( NF <= 5 ) {GeomOK = 0; COORDRecord = infinity; nat = natom - 1; natom = 0; next} 
   if( NF == 6 && GeomOK == 1){ 
       lab = "  "
       if ($2 == -1) {lab = "XX"}
       if ($2 ==  1) {lab = "H "}
       if ($2 ==  3) {lab = "Li"}
       if ($2 ==  4) {lab = "Be"}
       if ($2 ==  5) {lab = "B "}
       if ($2 ==  6) {lab = "C "}
       if ($2 ==  7) {lab = "N "}
       if ($2 ==  8) {lab = "O "}
       if ($2 ==  9) {lab = "F "}
       if ($2 == 11) {lab = "Na"}
       if ($2 == 12) {lab = "Mg"}
       if ($2 == 13) {lab = "Al"}
       if ($2 == 14) {lab = "Si"}
       if ($2 == 15) {lab = "P "}
       if ($2 == 16) {lab = "S "}
       if ($2 == 17) {lab = "Cl"}
       if ($2 == 19) {lab = "K "}
       if ($2 == 20) {lab = "Ca"}
       if ($2 == 21) {lab = "Sc"}
       if ($2 == 22) {lab = "Ti"}
       if ($2 == 23) {lab = "V "}
       if ($2 == 24) {lab = "Cr"}
       if ($2 == 25) {lab = "Mn"}
       if ($2 == 26) {lab = "Fe"}
       if ($2 == 27) {lab = "Co"}
       if ($2 == 28) {lab = "Ni"}
       if ($2 == 29) {lab = "Cu"}
       if ($2 == 30) {lab = "Zn"}
       if ($2 == 31) {lab = "Ga"}
       if ($2 == 35) {lab = "Br"}
       if ($2 == 38) {lab = "Sr"}
       if ($2 == 40) {lab = "Zr"}
       if ($2 == 42) {lab = "Mo"}
       if ($2 == 44) {lab = "Ru"}
       if ($2 == 45) {lab = "Rh"}
       if ($2 == 46) {lab = "Pd"}
       if ($2 == 47) {lab = "Ag"}
       if ($2 == 48) {lab = "Cd"}
       if ($2 == 50) {lab = "Sn"}
       if ($2 == 53) {lab = "I "}
       if ($2 == 58) {lab = "Ce"}
       if ($2 == 56) {lab = "Ba"}
       if ($2 == 28) {lab = "Ni"}
       if ($2 == 39) {lab = "Y"}
       if ($2 == 72) {lab = "Hf"}
       if ($2 == 73) {lab = "Ta"}
       if ($2 == 74) {lab = "W "}
       if ($2 == 77) {lab = "Ir"}
       if ($2 == 78) {lab = "Pt"}
       if ($2 == 79) {lab = "Au"}
       if ($2 == 80) {lab = "Hg"}
       if ($2 == 82) {lab = "Pb"}
       if ($2 == 83) {lab = "Bi"}
       if (lab == "  ") {print" --- ERROR !  Atom No.", $1," Atomic Number ",$2, " not defined ---" > "/dev/tty" }
       n[natom] = lab 
       x[natom] = $4  
       y[natom] = $5  
       z[natom] = $6  
       natom++ 
   }
}

END{if (FoundOK == 0)   {print" --- ERROR ! No geometry section in the output ---" > "/dev/tty" }
    if (FoundOK == 1)   {
        i = 0 ; while (i <= nat) { 
        printf "%+4s %12.6f %12.6f %12.6f\n", n[i],x[i],y[i],z[i]
        i++ 
        }
    }
}
