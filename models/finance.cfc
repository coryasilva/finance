component accessors="false"{
	/**
	* A lot of these function come from excel/openoffice and follow its abbreviated function name.
	* 
	* Credits:
	* https://support.office.com/en-gb/article/Financial-functions-reference-5658d81e-6035-4f24-89c1-fbf124c2b1d8?ui=en-US&rs=en-GB&ad=GB
	* https://github.com/handsontable/formula.js/blob/develop/lib/financial.js
	* 
	* TODO: IRR, RATE
	*/

	// Constructor
	finance function init(){
		return this;
	}
	
	/**
	* Calculates the future value of an investment based on a constant interest rate.
	*
    * @param rate 	 Interest rate per period
	* @param nper 	 Total number of periods (payments)
    * @param pmt 	 Payment made each period 
    * @param pv 	 Present Value 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
	*/
    public numeric function fv(required numeric rate, required numeric nper, required numeric pmt, numeric pv=0, numeric type=0) {
		var term = (1 + rate)^nper;
		var tmp = nper;
		if (rate != 0) {
			tmp = (term - 1) / rate;
		}
        return -(pv * term + pmt * tmp * (1 + rate * type));
    }

	/**
	* Calculates the present value of a loan or an investment, based on a constant interest rate.
	*
    * @param rate 	 Interest rate per period
	* @param nper 	 Total number of periods (payments)
    * @param pmt 	 Payment made each period 
    * @param fv 	 Future Value 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
	*/
    public numeric function pv(required numeric rate, required numeric nper, required numeric pmt, numeric fv=0, numeric type=0) {
        if (rate == 0) {
            return -fv - pmt * nper;
        }
        var term = (1 + rate)^nper;
        return -(fv + pmt * (term - 1) / rate * (1 + rate * type)) / term;
    }

	/**
	* Calculates the net present value of an investment by using a discount rate and a series of future payments/income
	*
    * @param rate 	 Interest rate per period
	* @param flows 	 Series of payments (negative) and income (positive).
	*/
	public numeric function npv(required numeric rate, required array flows) {
		var npv = 0;
		var len = arrayLen(flows);
		for (var i = 1; i <= len; i++) {
			npv += flows[i] / ((1 + rate)^i);
		}
		return npv;
	}

	/**
	* Calculates the number of periods for an investment based on periodic, constant payments and a constant interest rate.
	*
    * @param rate 	 Interest rate per period
    * @param pmt 	 Payment made each period 
	* @param pv 	 Present Value 
    * @param fv 	 Future Value 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
	*/
	public numeric function nper(required numeric rate, required numeric pmt, required numeric pv, numeric fv=0, numeric type=0) {
        if (rate == 0) {
            return -(fv + pv) / pmt;
        }
        var tmp = pmt * (1 + rate * type);
        return log((tmp - fv * rate) / (tmp + pv * rate)) / log(1 + rate);
    }

	/**
    * Calculate payment on loan. (Principal + Interest)
    * 
    * @param rate 	 Interest rate per period
	* @param nper 	 Total number of periods (payments)
    * @param pv 	 Present Value 
    * @param fv 	 Future Value (Generally zero for calculating payments. Non zero for pay down to ammount.) 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
    */
    public numeric function pmt(required numeric rate, required numeric nper, required numeric pv, numeric fv=0, numeric type=0) {
		if (rate == 0) {
            return -(fv + pv) / nper;
        }
        var term = (1 + rate)^nper;
        return -rate * (fv + pv * term) / ((1 + rate * type) * (term - 1));
	}

	/**
    * Calculate interest payment
    * 
    * @param rate 	 Interest rate per period
	* @param per 	 Specifies the period and must be in the range 1 to nper
	* @param nper 	 Total number of periods (payments)
    * @param pv 	 Present Value 
    * @param fv 	 Future Value (Generally zero for calculating payments. Non zero for pay down to ammount.) 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
    */
    public numeric function ipmt(required numeric rate, required numeric per, required numeric nper, required numeric pv, numeric fv=0, numeric type=0) {
        if (type == 1 && per == 1) {
            return 0;
        }
        var pmt = this.pmt(rate, nper, pv, fv, type);
        var ipmt = this.fv(rate, per - 1, pmt, pv, type) * rate;
		return type ? ipmt / (1 + rate) : ipmt;
    }

	/**
    * Calculate principal payment
    * 
    * @param rate 	 Interest rate per period
	* @param per 	 Specifies the period and must be in the range 1 to nper
	* @param nper 	 Total number of periods (payments)
    * @param pv 	 Present Value 
    * @param fv 	 Future Value (Generally zero for calculating payments. Non zero for pay down to ammount.) 
	* @param type 	 The number 0 (zero) or 1 and indicates when payments are due
    */
    public numeric function ppmt(required numeric rate, required numeric per, required numeric nper, required numeric pv, numeric fv=0, numeric type=0) {
        var pmt = this.pmt(rate, nper, pv, fv, type);
        return pmt - this.ipmt(rate, per, nper, pv, fv, type);
    }
	
	/**
	* Calculates effective annual interest rate
	* 
	* @param nominalRate 	Nominal Rate
	* @param npery 	 		Number of compounding periods per year
	*/
	public numeric function effect(required numeric nominalRate, required numeric npery) {
		return (1 + (nominalRate/npery))^npery - 1;
	}

	/**
	* Calculates nominal annual interest rate
	* 
	* @param nominalRate 	Nominal Rate
	* @param npery 	 		Number of compounding periods per year
	*/
	public numeric function nominal(required numeric effectiveRate, required numeric npery) {
		return ((effectiveRate + 1)^(1/npery) - 1) * npery;
	}

	/** 
	* Calculates a Loan to Value ratio
	*
	* @param la	 		Loan Amount
	* @param v			Asset Value
	* @param minV		Minimum value
	*/
    public numeric function ltv(required numeric la, required numeric v, numeric minV=1) {
        return v <= minV ? la/minV : la/v;
    }

}