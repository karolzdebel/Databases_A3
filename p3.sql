CREATE OR REPLACE FUNCTION p3(acc text, nm text, prov text, lt real) RETURNS void AS $$
DECLARE
	cust customer%ROWTYPE;
BEGIN
	INSERT INTO customer VALUES (acc,nm,prov,0,lt);
	
	FOR cust IN SELECT * FROM customer LOOP

		raise notice 'Account:% | Cname:% | Province:% | Cbalance:% | Crlimit:%'
			,cust.Account,cust.Cname,cust.Province,cust.Cbalance,cust.Crlimit;

	END LOOP;
	
END;
$$ LANGUAGE plpgsql;
