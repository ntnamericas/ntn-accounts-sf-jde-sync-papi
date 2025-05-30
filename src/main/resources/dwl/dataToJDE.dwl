%dw 2.0
import * from dw::Core
import * from dw::core::Strings
output application/json
fun extractFirstPart(a, b) =
    if ( a != null ) (a splitBy b)[0] as String else null
var phoneR = if(payload.phone != null)(payload.phone replace /[()\-\s]/ with "") else ""
var FaxR = if(payload.fax != null)(payload.fax replace /[()\-\s]/ with "") else ""

fun cleanBillToNumber(a) =
    if (a != null and (a contains ",")) 
        a replace /,/ with "" 
    else if (a != null) 
        a as Number 
    else 
        null      
---
{
	"id": payload.id,
	"nbcaMarket": upper(extractFirstPart(payload.nbcaMarket, "-") ),
	"region": upper(extractFirstPart(payload.region,"-")),
	"custTypeCode": upper(extractFirstPart (payload.custTypeCode , "-")),
	"ntnSalesRep": upper(extractFirstPart(payload.ntnSalesRep, "-")),
	"customerServiceCoordinatorCode": upper(extractFirstPart (payload.customerServiceCoordinatorCode , "-")),
	"mktRep": upper(extractFirstPart(payload.mktRep,"-")),
	"customerPriceGroup40PC":  upper(extractFirstPart(payload.customerPriceGroup40PC,"-")),
	"engineer": upper(extractFirstPart(payload.engineer, "-")),
	"ntnMarketCode": upper(extractFirstPart(payload.ntnMarketCode, "-")),
	"ntnGlobalMarket": upper(extractFirstPart(payload.ntnGlobalMarket,"-")),
	"shippingStreet": upper(payload.shippingStreet) splitBy  "\n",
	"shippingStateCode": if(payload.shippingStateCode != null)upper(payload.shippingStateCode) else "",
	"shippingPostalCode": if (payload.shippingPostalCode != null) upper(payload.shippingPostalCode) else  "",
	"alphaName": if ( payload.alphaName != null and sizeOf(payload.alphaName as String) <= 40 ) upper(payload.alphaName) else payload.alphaName,
	"jdeAddressNumber": if (payload.jdeAddressNumber != null) payload.jdeAddressNumber as Number as String else null,
	"billToNumber": if (cleanBillToNumber(payload.billToNumber) != null) cleanBillToNumber(payload.billToNumber) as String else null,
	"parentNumber": if(cleanBillToNumber(payload.parentNumber) != null) cleanBillToNumber(payload.parentNumber) as String else null ,
	"ntnAdvPrcGrp": upper(extractFirstPart(payload.ntnAdvPrcGrp, "-")),
	"billingAddressType": upper(extractFirstPart(payload.billingAddressType, "-")),
	"shippingCountryCode": payload.shippingCountryCode,
	"shippingCity": if (payload.shippingCity != null) upper(payload.shippingCity) else "",
	"dunsNumber": if (payload.dunsNumber != null ) upper(payload.dunsNumber) else null,
	"fax": if(payload.fax != null)"(" ++ FaxR[0 to 2] ++ ")" ++ FaxR[3 to 5] ++ "-" ++ FaxR[6 to 9] else null,
	"phone": if(payload.phone != null)"(" ++ phoneR[0 to 2] ++ ")" ++ phoneR[3 to 5] ++ "-" ++ phoneR[6 to 9] else null,
	"ntnCompanyName":  if (payload.ntnCompanyName != null) upper(payload.ntnCompanyName) else null,
	"advPriceAG": "NO",
	"advPriceEMB": "NO",
	"advPriceUCP": "EMB" ,
  	"lastModifiedById": payload.lastModifiedById,
  	"searchType": payload.searchType
    
}