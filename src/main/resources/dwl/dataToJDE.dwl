%dw 2.0
import * from dw::Core
import * from dw::core::Strings
output application/json
fun extractFirstPart(a, b) =
    if ( a != null ) (a splitBy b)[0] as String else null
var alphaNamemodified =  payload.alphaName replace /[^a-zA-Z\s]/ with " "
var phoneR = if(payload.phone != null)(payload.phone replace /[()\-\s]/ with "") else ""
fun cleanBillToNumber(a) =
    if ( a contains "," ) a replace /,/ with "" 
    else if ( a contains "." ) a replace /\./ with "" 
    else 
        null

      
---
{
	"id": upper(payload.id),
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
	"alphaName": if ( alphaNamemodified != null and sizeOf(alphaNamemodified as String) <= 40 ) upper(alphaNamemodified) else alphaNamemodified,
	"jdeAddressNumber": if (payload.jdeAddressNumber != null) payload.jdeAddressNumber as Number as String else null,
	"billToNumber": cleanBillToNumber(payload.billToNumber),
	"parentNumber": cleanBillToNumber(payload.parentNumber),
	"ntnAdvPrcGrp": upper(extractFirstPart(payload.ntnAdvPrcGrp, "-")),
	"billingAddressType": upper(extractFirstPart(payload.billingAddressType, "-")),
	"shippingCountryCode": payload.shippingCountryCode,
	"shippingCity": if (payload.shippingCity != null) upper(payload.shippingCity) else "",
	"dunsNumber": if (payload.dunsNumber != null ) upper(payload.dunsNumber) else null,
	"fax":if(payload.fax != null) "(" ++ payload.fax[0 to 2] ++ ")" ++ payload.fax[3 to 5] ++ "-" ++ payload.fax[6 to 9] else null,
	"phone": if(payload.phone != null)"(" ++ phoneR[0 to 2] ++ ")" ++ phoneR[3 to 5] ++ "-" ++ phoneR[6 to 9] else null,
	"ntnCompanyName":  if (payload.ntnCompanyName != null) upper(payload.ntnCompanyName) else null,
	"advPriceAG": "NO",
	"advPriceEMB": "NO",
	"advPriceUCP": "EMB" ,
  "lastModifiedById": payload.lastModifiedById,
  "searchType": 
    if (payload.lastModifiedById != "005VC000004ZZqDYAW" and payload.lastModifiedById != "005f4000000x8iHAAQ") 

    if (payload.ntnCompanyName == "NBCC" and payload."type" == "Customer" and payload.status == "Active") 
        "C"
    else if (payload.ntnCompanyName == "NBCC" and payload."type" == "Customer" and payload.status != "Active")
        "CX"
    else if (payload.ntnCompanyName == "NBCC" and payload."type" == "End User" and payload.status == "Active") 
        "EU"
    else if (payload.ntnCompanyName == "NBCC" and payload."type" == "End User" and payload.status != "Active") 
        "EUX"
    else 
        ""
        else ""
}