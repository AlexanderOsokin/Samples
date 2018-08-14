using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;

using Newtonsoft.Json;
using RndBook.DataModel;
using RndBook.Services.Network;

namespace RndBook.Services.DataSource
{
    public class BackendDataSource<T> : IDataSource<T>
    {
        IBackendClient _backendClient;
        const string _apiVer = "api";

        public int PageSize { get; set; } = 10;

        public BackendDataSource(IBackendClient backendClient)
        {
            _backendClient = backendClient;
        }

        public async Task<IEnumerable<T>> GetItemsAsync(int page)
        {
            var json = await _backendClient.GetAsync(BuildUrl(page));
            if (string.IsNullOrEmpty(json?.Data))
                return null;

            try
            {
               return await Task.Run(() => JsonConvert.DeserializeObject<IEnumerable<T>>(json.Data));
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
        }

        string BuildUrl(int page)
        {
            return $"{_apiVer}/?page={page}&results={PageSize}";
        }
    }
}
