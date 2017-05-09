component extends="coldbox.system.testing.BaseModelTest" model="models.finance"{
	/*********************************** LIFE CYCLE Methods ***********************************/
	function beforeAll(){
		// setup the model
		super.setup();
		// init the model object
		model.init();
	}
	function afterAll(){}
	/*********************************** BDD SUITES ***********************************/
	function run(){
		describe('Finance Suite', function(){
			it('can throw on invalid type', function() {
				//expect(function() {model.fv(precisionEvaluate(0.06/12), 10, -200, -500, 2);}).toThrow();
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.06/12), 10, -200, -500, 1);
				expect(val).toBe(2581.403374060179);
				//       excel:  2581.403374060120000000000000000000
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.12/12), 12, -1000);
				expect(val).tobe(12682.50301319697);
				//       excel:  12682.503013197000000000000000000000 
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.11/12), 35, -2000, 0, 1);
				expect(val).tobe(82846.24637189951); 
				//       excel:  82846.246371900500000000000000000000
            });
			it('can calculate FV', function() {
				var val = model.fv(precisionEvaluate(0.06/12), 12, -100, -1000, 1);
				expect(val).tobe(2301.401830340941);
				//       excel:  2301.401830340900000000000000000000
            });
			it('can calculate PV', function() {
				var val = model.pv(precisionEvaluate(0.08/12), 20*12, 500);
				expect(val).tobe(-59777.14585118801);
				//       excel:  -59777.145851187800000000000000000000
            });
			it('can calculate NPV', function() {
				var val = model.npv(0.10, [-10000, 3000, 4200, 6800]);
				expect(val).tobe('1188.4434123352244048698859367529540332'); 
				//       excel:   1188.443412335220000000000000000000
            });
			it('can calculate NPV', function() {
				var val = precisionEvaluate(model.npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000));
				expect(val).tobe('1922.0615549323722008930715071189742884');
				//       excel:   1922.061554932370000000000000000000
            });
			it('can calculate NPV', function() {
				var val = precisionEvaluate(model.npv(0.08, [8000, 9200, 10000, 12000, 14500, -9000]) + (-40000));
				expect(val).tobe(-3749.465087015571);
				//       excel:  -3749.465087015570000000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000, 10000, 1);
				expect(val).tobe('59.6738656742945993145738138213055717');
				//       excel:  59.673865674294600000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000, 10000);
				expect(val).tobe('60.0821228537616723813741807210307493');
				//       excel:   60.082122853761700000000000000000
            });
			it('can calculate NPER', function() {
				var val = model.nper(precisionEvaluate(0.12/12), -100, -1000);
				expect(val).tobe(-9.578594039813);
				//       excel:  -9.578594039813160000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.08/12), 10, 10000);
				expect(val).tobe(-1037.032089359152);
				//       excel:  -1037.032089359150000000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.08/12), 10, 10000, 0, 1);
				expect(val).tobe(-1030.164327177966);
				//       excel:  -1030.164327177970000000000000000000
            });
			it('can calculate PMT', function() {
				var val = model.pmt(precisionEvaluate(0.06/12), 18*12, 0, 50000);
				expect(val).tobe(-129.081160867991);
				//       excel:  -129.081160867991000000000000000000
            });
			it('can throw on invalid per IPMT', function() {
				expect(function () {model.ipmt(precisionEvaluate(0.10/12), 0, 3*12, 8000);}).toThrow();
            });
			it('can calculate IPMT', function() {
				var val = model.ipmt(precisionEvaluate(0.10/12), 1, 3*12, 8000);
				expect(val).tobe(-66.6666666666667);
				//       excel:  -66.666666666666700000000000000000
            });
			it('can calculate IPMT', function() {
				var val = model.ipmt(0.10, 3, 3, 8000);
				expect(val).tobe(-292.447129909366);
				//       excel:  -292.447129909366000000000000000000
            });
			it('can throw on invalid per PPMT', function() {
				expect(function () {model.ppmt(precisionEvaluate(0.10/12), 25, 2*12, 2000);}).toThrow();
            });
			it('can calculate PPMT', function() {
				var val = model.ppmt(precisionEvaluate(0.10/12), 1, 2*12, 2000);
				expect(val).tobe(-75.6231860083663);
				//       excel:  -75.623186008366300000000000000000
            });
			it('can calculate PPMT', function() {
				var val = model.ppmt(0.08, 10, 10, 200000);
				expect(val).tobe(-27598.053462421372);
				//       excel:  -27598.053462421400000000000000000000
            });
			it('can calculate EFFECT', function() {
				var val = model.effect(0.0525, 4);
				expect(val).tobe('0.053542667370758056640625');
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
				expect(val).tobe(0.0525003198680);
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
				expect(val).toBe(0.01);
				//       excel:  0.007701472488201370000000000000
            });
			it('can calculate RATE', function() {
				var val = precisionEvaluate(model.rate(4*12, -200, 8000)*12);
				expect(val).toBe(0.924);
				//       excel:  0.092417669858416400000000000000
            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000, 18000, 21000])
				expect(val).toBe(-0.021);
				//       excel:  -0.021244848273410900000000000000

            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000, 18000, 21000, 26000])
				expect(val).toBe(0.087);
				//       excel:  0.086630948036522200000000000000
            });
			it('can calculate IRR', function() {
				var val = model.irr([-70000, 12000, 15000], -0.10);
				expect(val).toBe(-0.444);
				//       excel:  -0.443506941334740000000000000000
            });
			*/
			it('can calculate LTV', function() {
				var val = model.ltv(300000, 400000);
				expect(val).toBe(0.75);
				//       excel:  0.750000000000000000000000000000
            });
			it('can calculate LTV', function() {
				var val = model.ltv(200000, 300000);
				expect(val).toBe('0.6666666666666666666666666666666667');
				//       excel:  0.666666666666667000000000000000
            });
			it('can calculate LTV', function() {
				var val = model.ltv(300000, -100000);
				expect(val).toBe(300000);
				//       excel:  300000.000000000000000000000000000000
            });
			
		});
	}
}