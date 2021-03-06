
// autogenerated tests for w3strings (require modBase-Utils)
// language: en

function _test_verifyW3strings() : int {
    var failed: int;
    failed = 0;

    // test by id
    if (!assertTrue(GetLocStringById(2117688000) == "Dissolve", "w3string.byId: 2117688000")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688001) == "Produces", "w3string.byId: 2117688001")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688002) == "Weak", "w3string.byId: 2117688002")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688003) == "Standard", "w3string.byId: 2117688003")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688004) == "Strong", "w3string.byId: 2117688004")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688005) == "Solid", "w3string.byId: 2117688005")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688006) == "Nearly Unbreakable", "w3string.byId: 2117688006")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688007) == "Perfectly Balanced.", "w3string.byId: 2117688007")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688008) == "Well Balanced.", "w3string.byId: 2117688008")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688009) == "Perfectly Balanced.", "w3string.byId: 2117688009")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688010) == "Decently Balanced.", "w3string.byId: 2117688010")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688011) == "Poorly Balanced.", "w3string.byId: 2117688011")) failed += 1;
    if (!assertTrue(GetLocStringById(2117688012) == "Badly Balanced.", "w3string.byId: 2117688012")) failed += 1;

    // test by key
    if (!assertTrue(GetLocStringByKey("panel_button_inventory_wwaDissolve") == "Dissolve", "w3string.byKey: panel_button_inventory_wwaDissolve")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_produce") == "Produces", "w3string.byKey: wwa_produce")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_weakSword") == "Weak", "w3string.byKey: wwa_item_weakSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_standardSword") == "Standard", "w3string.byKey: wwa_item_standardSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_strongSword") == "Strong", "w3string.byKey: wwa_item_strongSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_solidSword") == "Solid", "w3string.byKey: wwa_item_solidSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_nUnbreakableSword") == "Nearly Unbreakable", "w3string.byKey: wwa_item_nUnbreakableSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_pBalancedSword") == "Perfectly Balanced.", "w3string.byKey: wwa_item_pBalancedSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_wBalancedSword") == "Well Balanced.", "w3string.byKey: wwa_item_wBalancedSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_pBalancedSword") == "Perfectly Balanced.", "w3string.byKey: wwa_item_pBalancedSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_dBalancedSword") == "Decently Balanced.", "w3string.byKey: wwa_item_dBalancedSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_poBalancedSword") == "Poorly Balanced.", "w3string.byKey: wwa_item_poBalancedSword")) failed += 1;
    if (!assertTrue(GetLocStringByKey("wwa_item_bBalancedSword") == "Badly Balanced.", "w3string.byKey: wwa_item_bBalancedSword")) failed += 1;

    // return number of failed
    return failed;
}

exec function test_verifyW3Strings() {
    logTestResult("Verify W3Strings", _test_verifyW3strings(), true);
}
