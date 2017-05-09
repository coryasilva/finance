component extends="coldbox.system.testing.BaseModelTest" model="models.finance"{
	/*********************************** LIFE CYCLE Methods ***********************************/
	function beforeAll(){
		// setup the model
		super.setup();
		// init the model object
		model.init();
	}
	function afterAll(){}
	/*********************************** HELPERS ***********************************/
	function fixer(x) {
		return precisionEvaluate(fix(precisionEvaluate(x * 10000000000)) / 10000000000);
	}
	/*********************************** BDD SUITES ***********************************/
	function run(){
		var epsilon = 0.0000001;
		describe('Finance Suite', function(){
			it('can throw on invalid type', function() {
				expect(function() {model.fv(precisionEvaluate(0.06/12), 10, -200, -500, 2);}).toThrow();
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.06/12), 10, -200, -500, 1);
				expect(fixer(val)).toBeCloseTo(2581.4033740, epsilon);
				//       excel:  2581.403374060120000000000000000000
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.12/12), 12, -1000);
				expect(fixer(val)).toBeCloseTo(12682.5030131, epsilon);
				//       excel:  12682.503013197000000000000000000000 
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.11/12), 35, -2000, 0, 1);
				expect(fixer(val)).toBeCloseTo(82846.2463718, epsilon); 
				//       excel:  82846.246371900500000000000000000000
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.06/12), 12, -100, -1000, 1);
				expect(fixer(val)).toBeCloseTo(2301.4018303, epsilon);
				//       excel:  2301.401830340900000000000000000000
            });
			it('can calculate PV', function() {
				var val = model.pv(precisionEvaluate(0.08/12), 20*12, 500);
				expect(fixer(val)).toBeCloseTo(-59777.1458511, epsilon);
				//       excel:  -59777.145851187800000000000000000000
            });
			it('can calculate NPV', function() {
				var val = model.npv(0.10, [-10000, 3000, 4200, 6800]);
				expect(fixer(val)).toBeCloseTo(1188.4434123, epsilon); 
				//       excel:   1188.443412335220000000000000000000
            });
			it('can calculate NPV', function() {
				var val = precisionEvaluate(model.npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000));
				expect(fixer(val)).toBeCloseTo(1922.0615549, epsilon);
				//       excel:   1922.061554932370000000000000000000
            });
			it('can calculate NPV', function() {
				var val = precisionEvaluate(model.npv(0.08, [8000, 9200, 10000, 12000, 14500, -9000]) + (-40000));
				expect(fixer(val)).toBeCloseTo(-3749.4650870, epsilon);
				//       excel:  -3749.465087015570000000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000, 10000, 1);
				expect(fixer(val)).toBeCloseTo(59.6738656, epsilon);
				//       excel:  59.673865674294600000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000, 10000);
				expect(fixer(val)).toBeCloseTo(60.0821228, epsilon);
				//       excel:   60.082122853761700000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000);
				expect(fixer(val)).toBeCloseTo(-9.5785940, epsilon);
				//       excel:  -9.578594039813160000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.08/12), 10, 10000);
				expect(fixer(val)).toBeCloseTo(-1037.0320893, epsilon);
				//       excel:  -1037.032089359150000000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.08/12), 10, 10000, 0, 1);
				expect(fixer(val)).toBeCloseTo(-1030.1643271, epsilon);
				//       excel:  -1030.164327177970000000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.06/12), 18*12, 0, 50000);
				expect(fixer(val)).toBeCloseTo(-129.0811608, epsilon);
				//       excel:  -129.081160867991000000000000000000
            });
			it('can throw on invalid per IPMT', function() {
				expect(function () {model.ipmt(precisionEvaluate(0.10/12), 0, 3*12, 8000);}).toThrow();
            });
			it('can calculate IPMT', function() {
				var val = model.ipmt(precisionEvaluate(0.10/12), 1, 3*12, 8000);
				expect(fixer(val)).toBeCloseTo(-66.6666666, epsilon);
				//       excel:  -66.666666666666700000000000000000
            });
			it('can calculate IPMT', function() {
				var val = model.ipmt(0.10, 3, 3, 8000);
				expect(fixer(val)).toBeCloseTo(-292.4471299, epsilon);
				//       excel:  -292.447129909366000000000000000000
            });
			it('can throw on invalid per PPMT', function() {
				expect(function () {model.ppmt(precisionEvaluate(0.10/12), 25, 2*12, 2000);}).toThrow();
            });
			it('can calculate PPMT', function() {
				var val = model.ppmt(precisionEvaluate(0.10/12), 1, 2*12, 2000);
				expect(fixer(val)).toBeCloseTo(-75.6231860, epsilon);
				//       excel:  -75.623186008366300000000000000000
            });
			it('can calculate PPMT', function() {
				var val = model.ppmt(0.08, 10, 10, 200000);
				expect(fixer(val)).toBeCloseTo(-27598.0534624, epsilon);
				//       excel:  -27598.053462421400000000000000000000
            });
			it('can calculate EFFECT', function() {
				var val = model.effect(0.0525, 4);
				expect(fixer(val)).toBeCloseTo(0.0535426, epsilon);
				//       excel:  0.053542667370758400000000000000
            });
			it('can throw on invalid rate EFFECT', function() {
				expect(function () { model.effect(-0.0525, 4); }).toThrow();
            });
			it('can throw on invalid npery EFFECT', function() {
				expect(function () { model.effect(0.0525, 0.5); }).toThrow();
            });
			it('can calculate NOMINAL', function() {
				var val = model.nominal(0.053543, 4);
				expect(fixer(val)).toBeCloseTo(0.0525003, epsilon);
				//       excel:  0.052500319868356000000000000000
            });
			it('can throw on invalid rate NOMINAL', function() {
				expect(function () { model.nominal(-0.053543, 4); }).toThrow();
            });
			it('can throw on invalid npery NOMINAL', function() {
				expect(function () { model.nominal(0.053543, 0.5); }).toThrow();
            });
			/*
			it('can calculate RATE', function() {
				var val = model.rate(4*12, -200, 8000);
				expect(fixer(val)).toBeCloseTo(0.0077014, epsilon);
				//       excel:  0.007701472488201370000000000000
            });
			it('can calculate RATE', function() {
				var val = precisionEvaluate(model.rate(4*12, -200, 8000)*12);
				expect(fixer(val)).toBeCloseTo(0.0924176, epsilon);
				//       excel:  0.092417669858416400000000000000
            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000, 18000, 21000]);
				expect(fixer(val)).toBeCloseTo(-0.0212448, epsilon);
				//       excel:  -0.021244848273410900000000000000

            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000, 18000, 21000, 26000]);
				expect(fixer(val)).toBeCloseTo('0.0866309', epsilon);
				//       excel:  0.086630948036522200000000000000
            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000], -0.10);
				expect(fixer(val)).toBeCloseTo(-0.4435069, epsilon);
				//       excel:  -0.443506941334740000000000000000
            });
			*/
			it('can calculate LTV', function() {
				var val = model.ltv(300000, 400000);
				expect(fixer(val)).toBeCloseTo(0.7500000, epsilon);
				//       excel:  0.750000000000000000000000000000
            });
			it('can calculate LTV', function() {
				var val = model.ltv(200000, 300000);
				expect(fixer(val)).toBeCloseTo(0.6666666, epsilon);
				//       excel:  0.666666666666667000000000000000
            });
			it('can calculate LTV', function() {
				var val = model.ltv(300000, -100000);
				expect(fixer(val)).toBeCloseTo(300000.0000000, epsilon);
				//       excel:  300000.000000000000000000000000000000
            });
			
		});
	}
}