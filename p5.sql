CREATE OR REPLACE FUNCTION p5() RETURNS void AS $$
DECLARE
	vend vendor%ROWTYPE;
	tCount integer;
BEGIN
	
	FOR vend IN SELECT * FROM vendor LOOP

		select COUNT(*) into tCount FROM vendor NATURAL JOIN transaction
			WHERE vend.Vno = Vno;

		raise notice 'Vno:% | Vname:% | New Balance:%',vend.Vno,vend.Vname,vend.Vbalance+tCount;
		
		UPDATE vendor SET Vbalance = Vbalance + tCount
			WHERE Vno = vend.Vno; 


	END LOOP;
	
END;
$$ LANGUAGE plpgsql;
