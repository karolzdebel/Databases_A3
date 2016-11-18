CREATE OR REPLACE FUNCTION p7() RETURNS void AS $$
DECLARE
	cust customer%ROWTYPE;
	servFee real;
BEGIN
	
	FOR cust IN SELECT * FROM customer LOOP

		IF (cust.Cbalance > cust.Crlimit) THEN 
			servFee:= (cust.Cbalance - cust.Crlimit)*0.1;
			
			raise notice 'Customer % has been charged a fee of %, new balance is %',cust.Cname,servFee, cust.Cbalance-servFee;

			UPDATE customer SET Cbalance = Cbalance - servFee
				WHERE cust.Account = Account; 
		END IF;	

	END LOOP;
	
END;
$$ LANGUAGE plpgsql;
