CREATE OR REPLACE FUNCTION f05() RETURNS integer AS $$
DECLARE
	vend vendor%ROWTYPE;
	tCount integer;
BEGIN
	
	FOR vend IN SELECT * FROM vendor LOOP

		select COUNT(*) into tCount FROM vendor NATURAL JOIN transaction
			WHERE vend.Vno = Vno;

		UPDATE vendor SET Vbalance = Vbalance + tCount
			WHERE Vno = vend.Vno; 

		raise notice 'Vno:% | Vname:% | New Balance:%',vend.Vno,vend.Vname,vend.Vbalance;

	END LOOP;
	
	RETURN 0;
END;
$$ LANGUAGE plpgsql;
