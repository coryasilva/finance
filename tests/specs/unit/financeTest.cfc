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
			it('can calculate FV', function() {
				expect(model.fv(0.06/12, 10, -200, -500, 1))
				.toBeCloseTo(2581.40337406, .00000001);
            });
			it('can calculate FV', function() {
				expect(model.fv(0.12/12, 12, -1000))
				.toBeCloseTo(12682.50301319, .00000001);
            });
			it('can calculate FV', function() {
				expect(model.fv(0.11/12, 35, -2000, 0, 1))
				.toBeCloseTo(82846.24637190, .00000001);
            });
			it('can calculate FV', function() {
				expect(model.fv(0.06/12, 12, -100, -1000, 1))
				.toBeCloseTo(2301.40183034, .00000001);
            });
			it('can calculate PV', function() {
				expect(model.pv(0.08/12, 20*12, 500))
				.toBeCloseTo(-59777.14585118, .00000001);
            });
			it('can calculate NPV', function() {
				expect(model.npv(0.10, [-10000, 3000, 4200, 6800]))
				.toBeCloseTo(1188.44341233, .00000001);
            });
			it('can calculate NPV', function() {
				expect(model.npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000))
				.toBeCloseTo(1922.06155493, .00000001);
            });
			it('can calculate NPV', function() {
				expect(model.npv(0.08, [8000, 9200, 10000, 12000, 14500, -9000]) + (-40000))
				.toBeCloseTo(-3749.46508701, .00000001);
            });
			it('can calculate NPER', function() {
				expect(model.nper(0.12/12, -100, -1000, 10000, 1))
				.toBeCloseTo(59.67386567, .00000001);
            });
			it('can calculate NPER', function() {
				expect(model.nper(0.12/12, -100, -1000, 10000))
				.toBeCloseTo(60.08212285, .00000001);
            });
			it('can calculate NPER', function() {
				expect(model.nper(0.12/12, -100, -1000))
				.toBeCloseTo(-9.57859404, .00000001);
            });
			it('can calculate PMT', function() {
				expect(model.pmt(0.08/12, 10, 10000))
				.toBeCloseTo(-1037.03208935, .00000001);
            });
			it('can calculate PMT', function() {
				expect(model.pmt(0.08/12, 10, 10000, 0, 1))
				.toBeCloseTo(-1030.16432717, .00000001);
            });
			it('can calculate PMT', function() {
				expect(model.pmt(0.06/12, 18*12, 0, 50000))
				.toBeCloseTo(-129.08116086, .00000001);
            });
			it('can calculate IPMT', function() {
				expect(model.ipmt(0.10/12, 1, 3*12, 8000))
				.toBeCloseTo(-66.66666666, .00000001);
            });
			it('can calculate IPMT', function() {
				expect(model.ipmt(0.10, 3, 3, 8000))
				.toBeCloseTo(-292.44712990, .00000001);
            });
			it('can calculate PPMT', function() {
				expect(model.ppmt(0.10/12, 1, 2*12, 2000))
				.toBeCloseTo(-75.62318600, .00000001);
            });
			it('can calculate PPMT', function() {
				expect(model.ppmt(0.08, 10, 10, 200000))
				.toBeCloseTo(-27598.05346242, .00000001);
            });
			it('can calculate EFFECT', function() {
				expect(model.effect(0.0525, 4))
				.toBeCloseTo(0.05354266, .00000001);
            });
			it('can calculate NOMINAL', function() {
				expect(model.nominal(0.053543, 4))
				.toBeCloseTo(0.05250032, .00000001);
            });
			/*
			it('can calculate RATE', function() {
				expect(model.rate(4*12, -200, 8000))
				.toBeCloseTo(0.01, .000001);
            });
			it('can calculate RATE', function() {
				expect(model.rate(4*12, -200, 8000)*12)
				.toBeCloseTo(0.924, .000001);
            });
			it('can calculate IRR', function() {
				expect(model.irr([-70000, 12000, 15000, 18000, 21000]))
				.toBeCloseTo(-0.021, .000001);
            });
			it('can calculate IRR', function() {
				expect(model.irr([-70000, 12000, 15000, 18000, 21000, 26000]))
				.toBeCloseTo(0.087, .000001);
            });
			it('can calculate IRR', function() {
				expect(model.irr([-70000, 12000, 15000, 18000, 21000, 26000], -0.10))
				.toBeCloseTo(-0.444, .000001);
            });
			*/
			it('can calculate LTV', function() {
				expect(model.ltv(300000, 400000))
				.toBeCloseTo(0.75, .00000001);
            });
			it('can calculate LTV', function() {
				expect(model.ltv(300000, -100000))
				.toBeCloseTo(300000, .00000001);
            });
		});
	}
}