component accessors="false"{
	/**
	* A lot of these function come from excel/openoffice and follow its abbreviated function name.
	* 
	* Credits:
	* https://support.office.com/en-gb/article/Financial-functions-reference-5658d81e-6035-4f24-89c1-fbf124c2b1d8?ui=en-US&rs=en-GB&ad=GB
	* https://github.com/handsontable/formula.js/blob/develop/lib/financial.js
	* 
	* Note: PrecisionEvaluate() only uses BigDecimal for + -  * / anything else will end up as a float or double
	* https://cfdocs.org/precisionevaluate
	* 
	* TODO: IRR, RATE
	*/

	// Constructor
	finance function init(){
		return this;
	}

	// Private
	private function validateType(type, method) {
		if (type != 0 && type != 1) {
			throw('finance.#method#: type parameters must be 1 or 0');
		}
	}
	
	// Public
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
		validateType(type, 'fv');
		rate = javaCast('BigDecimal', rate);
		nper = javaCast('int', nper);
		pmt = javaCast('BigDecimal', pmt);
		pv = javaCast('BigDecimal', pv);
		var term = rate.add(javaCast('BigDecimal', 1)).pow(nper);
		var tmp = nper;
		if (rate != 0) {
			tmp = precisionEvaluate((term - 1) / rate);
		}
        return precisionEvaluate(-(pv * term + pmt * tmp * (1 + rate * type)));
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
		validateType(type, 'pv');
        rate = javaCast('BigDecimal', rate);
		nper = javaCast('int', nper);
		pmt = javaCast('BigDecimal', pmt);
		fv = javaCast('BigDecimal', fv);
		if (rate == 0) {
            return precisionEvaluate(-fv - pmt * nper);
        }
        var term = rate.add(javaCast('BigDecimal', 1)).pow(nper);
        return precisionEvaluate(-(fv + pmt * (term - 1) / rate * (1 + rate * type)) / term);
    }

	/**
	* Calculates the net present value of an investment by using a discount rate and a series of future payments/income
	*
    * @param rate 	 Interest rate per period
	* @param flows 	 Series of payments (negative) and income (positive).
	*/
	public numeric function npv(required numeric rate, required array flows) {
		rate = javaCast('BigDecimal', rate);
		var npv = 0;
		var len = arrayLen(flows);
		for (var i = 1; i <= len; i++) {
			//npv += flows[i] / ((1 + rate)^i);
			var tmp = javaCast('BigDecimal', 1).add(rate).pow(javaCast('int', i));
			npv = precisionEvaluate(npv + (flows[i] / tmp));
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
		validateType(type, 'nper');
        if (rate == 0) {
            return precisionEvaluate(-(fv + pv) / pmt);
        }
        var tmp = precisionEvaluate(pmt * (1 + rate * type));
		var p1 = log(precisionEvaluate((tmp - fv * rate) / (tmp + pv * rate)));
		var p2 = log(precisionEvaluate(1 + rate));
        return precisionEvaluate(p1/p2);
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
		validateType(type, 'pmt');
		rate = javaCast('BigDecimal', rate);
		nper = javaCast('int', nper);
		pv = javaCast('BigDecimal', pv);
		fv = javaCast('BigDecimal', fv);
		if (rate == 0) {
            return precisionEvaluate(-(fv + pv) / nper);
        }
        var term = rate.add(javaCast('BigDecimal', 1)).pow(nper);
        return precisionEvaluate(-rate * (fv + pv * term) / ((1 + rate * type) * (term - 1)));
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
		validateType(type, 'ipmt');
		if (per < 1 || per > nper) {
			throw('finance.ipmt: per must be GTE 1 and LTE nper');
		}
        rate = javaCast('BigDecimal', rate);
		if (type == 1 && per == 1) {
            return 0;
        }
        var pmt = this.pmt(rate, nper, pv, fv, type);
        var ipmt = precisionEvaluate(this.fv(rate, per - 1, pmt, pv, type) * rate);
		return type ? precisionEvaluate(ipmt / (1 + rate)) : ipmt;
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
		validateType(type, 'ppmt');
		if (per < 1 || per > nper) {
			throw('finance.ipmt: per must be GTE 1 and LTE nper');
		}
        var pmt = this.pmt(rate, nper, pv, fv, type);
        return precisionEvaluate(pmt - this.ipmt(rate, per, nper, pv, fv, type));
    }
	
	/**
	* Calculates effective annual interest rate
	* 
	* @param nominalRate 	Nominal Rate
	* @param npery 	 		Number of compounding periods per year
	*/
	public numeric function effect(required numeric nominalRate, required numeric npery) {
		if (nominalRate <= 0) {
			throw('finance.effect: nominalRate must be greater than 0');
		}
		if (npery < 1) {
			throw('finance.effect: npery must be an integer GTE 1');
		}
		var rate = javaCast('BigDecimal', nominalRate);
		return rate.divide(javaCast('BigDecimal', npery)).add(javaCast('BigDecimal', 1)).pow(javaCast('int', npery)).subtract(javaCast('BigDecimal',1));
	}

	/**
	* Calculates nominal annual interest rate
	* 
	* @param nominalRate 	Nominal Rate
	* @param npery 	 		Number of compounding periods per year
	*/
	public numeric function nominal(required numeric effectiveRate, required numeric npery) {
		if (effectiveRate <= 0) {
			throw('finance.nominal: effectiveRate must be GT 0');
		}
		if (npery < 1) {
			throw('finance.nominal: npery must be an integer GTE 1');
		}
		var tmp = precisionEvaluate((rate + 1)^(1/npery));
		return precisionEvaluate((tmp - 1) * npery);
	}

	/** 
	* Calculates a Loan to Value ratio
	*
	* @param la	 		Loan Amount
	* @param v			Asset Value
	* @param minV		Minimum value
	*/
    public numeric function ltv(required numeric la, required numeric v, numeric minV=1) {
        return v <= minV ? precisionEvaluate(la/minV) : precisionEvaluate(la/v);
    }

}