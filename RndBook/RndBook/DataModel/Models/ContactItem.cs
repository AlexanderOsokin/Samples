using System;
using Newtonsoft.Json;

namespace RndBook.DataModel.Models
{
    public class ContactItem: IContactItem
    {
        [JsonProperty("name.first")]
        public string FirstName { get; set; }
        [JsonProperty("name.last")]
        public string LastName { get; set; }
        [JsonProperty("name.last")]
        public string MiddleName { get; set; }
        [JsonProperty("cell")]
        public string Phone { get; set; }
        [JsonProperty("email")]
        public string Mail { get; set; }
        [JsonProperty("picture.large")]
        public string ImageUrl { get; set; }
    }
}
