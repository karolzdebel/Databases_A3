CREATE OR REPLACE FUNCTION f02(name text) RETURNS integer AS $$
DECLARE
	c1 cursor for select Account,Cname,Province 
		from customer NATURAL JOIN transaction NATURAL JOIN vendor 
		WHERE vendor.Vname = name;
	pNum text;
	pName text;
	pProvince text;
BEGIN
	open c1;

	raise notice 'Found following customers who had transactions with %',name;
	LOOP
		fetch c1 into pNum,pName,pProvince;
		exit when not found;
		raise notice 'number:% | name:% | province:%',pNum,pName,pProvince;
	
	END LOOP;
	close c1;
	
	RETURN 0;
END;
$$ LANGUAGE plpgsql;
