NAMESPACE Siemens.Ax.TiaxExampleLibrary

    /// Wrapper FB for use in TIA Portal. 
    /// Serves as an pass-through interface to gain access/control to SIMATIC AX "Structured Text" OOP language constructs.
    FUNCTION_BLOCK ParkingCounterWrapper

        VAR_INPUT
            /// lightbarrier "outside" indicating a drive-in intention
            {S7.extern = ReadWrite}
            BSensorOutside : BOOL;

            /// lightbarrier "inside" indicating a drive-out intention
            {S7.extern = ReadWrite}
            BSensorInside : BOOL;

            /// maximum amount of cars which can be inside the car-park in parallel
            {S7.extern = ReadWrite}
            Limit : INT;
        END_VAR
        VAR_OUTPUT
            /// amount of cars currently inside the car-park in parallel
            {S7.extern = Read}
            countValue : DINT;
        END_VAR
        VAR
            /// SIMATIC AX class instance
            c : ParkingCounter;
            /// initializing routine passed
            init : BOOL;
        END_VAR

        IF NOT (init) THEN
            c.BSensorOutside := REF(BSensorOutside);
            c.BSensorInside := REF(BSensorInside);
            c.Limit := Limit;
            init := TRUE;
        END_IF;
        c.Execute();
        countValue := c.GetAmountOfParkedItems ();

    END_FUNCTION_BLOCK

END_NAMESPACE