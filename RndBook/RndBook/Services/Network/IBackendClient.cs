using System;
using System.Threading.Tasks;

namespace RndBook.Services.Network
{
    public interface IBackendResponse
    {
        bool IsSuccess { get; set;}
        string ErrorDescription { get; set; }
        string Data { get; set; }
    }

    public interface IBackendClient
    {
        Task<IBackendResponse> GetAsync(string url);
    }
}
