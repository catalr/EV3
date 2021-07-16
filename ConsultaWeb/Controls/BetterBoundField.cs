using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConsultaWeb
{
    public class BetterBoundField : BoundField
    {
        protected override object GetValue(Control controlContainer)
        {
            if (DataField.Contains("."))
            {
                var component = DataBinder.GetDataItem(controlContainer);
                return DataBinder.Eval(component, DataField);
            }
            return base.GetValue(controlContainer);
        }
    }
}