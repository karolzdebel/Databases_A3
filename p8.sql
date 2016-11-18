CREATE OR REPLACE FUNCTION f08(tNum text, vNum text, accNum text, amt real) RETURNS void AS $$
DECLARE
	cust customer%ROWTYPE;
	vend vendor%ROWTYPE;
	newTrans transaction%ROWTYPE;	
BEGIN
	
	newTrans := (tNum,vNum,accNum,CURRENT_DATE,amt);

	INSERT INTO transaction VALUES (tNum,vNum,accNum,CURRENT_DATE,amt);

	UPDATE customer SET Cbalance = Cbalance - amt
		WHERE accNum = Account; 

	UPDATE vendor SET Vbalance = Vbalance + amt
		WHERE Vno = vNum;

	SELECT * into cust FROM customer 
		WHERE Account = accNum;

	SELECT * into vend FROM vendor
		WHERE Vno = vNum;

	raise notice 'New transaction: %',newTrans;
	raise notice 'Customer %(Account %) sent % to vendor %(Vno %). Customer updated balance is %. Vendor updated balance is %.',
		cust.Cname,cust.Account,amt,vend.Vname,vend.Vno,cust.Cbalance,vend.Vbalance;	
	
END;
$$ LANGUAGE plpgsql;
