CREATE OR REPLACE FUNCTION f06() RETURNS void AS $$
DECLARE
	vend vendor%ROWTYPE;
	vendFee real;
BEGIN
	
	FOR vend IN SELECT * FROM vendor LOOP

		vendFee = vend.Vbalance*0.04;
		
		raise notice 'Vname:% | Fee Charged:% | New Balance:%',vend.Vname,vendFee,vend.Vbalance-vendFee;
		
		UPDATE vendor SET Vbalance = Vbalance - vendFee
			WHERE Vno = vend.Vno; 


	END LOOP;
END;
$$ LANGUAGE plpgsql;
